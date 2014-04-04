class Ressource < ActiveRecord::Base
		belongs_to	:flat
		has_many	:ressourceentries
		attr_accessor :entryLength
		attr_accessor :chart
		attr_accessor :chartDateRange

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
  		values = {"labels" => [],"data" => []}
	    
	    #calc for all days
	    for i in 0 ... res.size-1
	    	entry = res[i]
	    	nextEntry = res[i+1]
	    	days = nextEntry.date.to_date - entry.date.to_date
	    	if days == 1
	    		values["labels"] << entry.date.to_date
	    		values["data"] << ((nextEntry.value - entry.value)*resource.pricePerUnit).round(2)
	    		
	    	else
	    		costs =  ((nextEntry.value - entry.value)*resource.pricePerUnit)/days
	    		(entry.date.to_date .. nextEntry.date.to_date.yesterday).each do |date|
  					values["labels"] << date
  					values["data"] << costs.round(2)
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
