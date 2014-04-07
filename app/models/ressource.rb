class Ressource < ActiveRecord::Base
		belongs_to	              :flat
		has_many	                :ressourceentries
		attr_accessor             :entryLength
		attr_accessor             :chart
		attr_accessor             :chartDateRange
    validates                 :name,:startDate, :unit, :startValue,  presence: true
    validates_numericality_of :pricePerUnit, :greater_than => 0
    
	def self.find_resource_with_user_constraint(id, user)
        Ressource.where(id: id, flat_id: user.flat.id).first
    end

    def self.setAttributes(resources)
		for index in 0 ... resources.size
			resources[index].entryLength = resources[index].ressourceentries.size
			resources[index].chart = ''
			res = resources[index].ressourceentries.sort! {|a,b| a.date <=> b.date}
			resources[index].chartDateRange = OpenStruct.new({startDate: res.first.date, endDate: res.last.date})
		end
		resources
    end

    def self.getOverviewData (from, to, resource)
  		statdata = calcStatisticData(from, to, resource)
  		returnData = OpenStruct.new({general: [], years: []})
      if statdata["labels"].size != 0

    		all = OpenStruct.new({name: I18n.t('activerecord.ressource.info_all'), usage: 0, costs: 0, firstEntry: nil, lastEntry: nil})
    		thisMonth = OpenStruct.new({name: I18n.t('activerecord.ressource.info_currentMonth'), usage: 0, costs: 0, firstEntry: nil, lastEntry: nil})
    		lastThreeMonth = OpenStruct.new({name: I18n.t('activerecord.ressource.info_lastthreemonths'), usage: 0, firstEntry: nil, lastEntry: nil})
    		currentYear = OpenStruct.new({name: statdata["labels"][0].year, usage: 0, costs: 0, firstEntry: nil, lastEntry: nil})

    		for i in 0...statdata["labels"].size
    			date = statdata["labels"][i]
    			entry = statdata["usage"][i]

    			addEntry(all, date, entry)
        		if date.year == Date.today.year && date.month == Date.today.month  # current month
        			addEntry(thisMonth, date, entry)
        		end
        		if (date.year*12+date.month) >= (Date.today.year*12+Date.today.month-2)  # last three months
        			addEntry(lastThreeMonth, date, entry)
        		end
        		if currentYear.firstEntry == nil || currentYear.lastEntry.year == date.year
        			addEntry(currentYear, date, entry)
        		else
        			returnData.years << setCosts(currentYear, resource)
        			currentYear = OpenStruct.new({name: date.year, usage: entry, costs: 0, firstEntry: nil, lastEntry: nil})
        		end
       	end

       		if (currentYear.firstEntry != nil)
       			returnData.years << setCosts(currentYear, resource);
       		end  
       		
          if (thisMonth.firstEntry != nil)
       			returnData.general << setCosts(thisMonth, resource);
       		end

       		if (lastThreeMonth.firstEntry != nil)
      		returnData.general << setCosts(lastThreeMonth, resource);
       		end

          if (all.firstEntry != nil)
          returnData.general << setCosts(all, resource);
          end
      end
    
    	returnData

    end

    def self.addEntry (overviewEntry, date, entry)
    	overviewEntry.usage += entry
    	if overviewEntry.firstEntry == nil
    		overviewEntry.firstEntry = date
    	end
    	overviewEntry.lastEntry = date
    end

    def self.setCosts (overviewEntry, resource)
    	fixCostsPerMonth = resource.monthlyCost + resource.annualCost/12
    	monthbetween = (overviewEntry.lastEntry.year*12+overviewEntry.lastEntry.month) - (overviewEntry.firstEntry.year*12+overviewEntry.firstEntry.month-1)
    	overviewEntry.costs = (monthbetween*fixCostsPerMonth + overviewEntry.usage * resource.pricePerUnit).round(2)
    	overviewEntry.usage = overviewEntry.usage.round(2)
      overviewEntry
    end

    def self.getChartData(from, to, resource)
    	#return values for one month => in days
    	statdata = calcStatisticData(from, to, resource)
    	returnData = {"labels" => [], "data" => []}

    	hideEvery = ((to.to_date - from.to_date)/23).round
    	
    	if hideEvery == 0
    		hideEvery = 1
    	end

    	sum = 0
    	for i in 0...statdata["labels"].size
    		if (statdata["labels"][i] >= from && statdata["labels"][i] <= to)
    			if i % hideEvery == 0
    				returnData["labels"] << statdata["labels"][i]
    				returnData["data"] << (sum/hideEvery).round(2)
    				sum = statdata["data"][i]
    			else
    				sum += statdata["data"][i]
    			end
    			
    		end
   		end
 		
    	returnData
	    
  	end

  	def self.calcStatisticData (from,to, resource)
  		res = resource.ressourceentries.sort! {|a,b| a.date <=> b.date}#.where(['date <= ?', to]).where(['date >= ?', from])
  		values = {"labels" => [],"data" => [], "usage"=>[]}
	    
	    #calc for all days
	    for i in 0 ... res.size-1
	    	entry = res[i]
	    	nextEntry = res[i+1]
	    	days = nextEntry.date.to_date - entry.date.to_date
	    	if days == 1
	    		values["labels"] << entry.date.to_date
	    		values["data"] << ((nextEntry.value - entry.value)*resource.pricePerUnit).round(2)
	    		values["usage"] << (nextEntry.value - entry.value)
	    		
	    	else
	    		usage = (nextEntry.value - entry.value)/days
	    		costs =  ((nextEntry.value - entry.value)*resource.pricePerUnit)/days
	    		(entry.date.to_date .. nextEntry.date.to_date.yesterday).each do |date|
  					values["labels"] << date
  					values["data"] << costs.round(2)
  					values["usage"] << usage
				end	
	    	end
	    end
      	values
  	end


    def self.calc(resource, page)
    	entries = nil
	    re = (resource.ressourceentries.sort! {|a,b| b.date <=> a.date})[(page.to_i-1)*5,page.to_i*5+1]
	    for index in 0 ... re.size
	    	entry = re[index]
	    	
  			if entry.isFirst == true
	    		entry.usage = 0
	   			entry.costs = 0
	    	else
	    		entry.usage = (entry.value - re[index+1].value)
	    		entry.costs = (entry.usage * resource.pricePerUnit).round(2)
	    	end
	    	if index==4
	    		break
	    	end
		end
		re[0, 5]
    end
end
