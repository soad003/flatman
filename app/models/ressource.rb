class Ressource < ActiveRecord::Base
		belongs_to	              :flat
		has_many	                :ressourceentries
		attr_accessor             :entryLength
		attr_accessor             :chart
		attr_accessor             :chartDateRange
    validates                 :name,:startDate, :unit, :pricePerUnit, :startValue,  presence: true
    validates_numericality_of :pricePerUnit, :greater_than => 0
    
    def self.get_months (date)
      (date.year*12+date.month)
    end

    def self.get_month_diff (date1, date2)
        (get_months(date2) - get_months(date1))
    end

    def self.get_resource_entries (from, to, resource)
      resource.ressourceentries.where(['date >= ? AND date <= ?', from, to]).sort! {|a,b| a.date <=> b.date}
    end

    def self.get_resource_entry_before (date, resource)
      entry = resource.ressourceentries.where(['date < ?', date]).sort! {|a,b| a.date <=> b.date}
      if entry != nil
        entry = entry.last
      end
      entry
    end

    def self.get_resource_entry_after (date, resource)
      entry = resource.ressourceentries.where(['date > ?', date]).sort! {|a,b| a.date <=> b.date}
      if entry != nil
        entry = entry.first
      end
      entry
    end

    def self.get_resource_entries_inkl_after_and_before (from, to, resource)
      returnEntries = []
      entries = get_resource_entries(from, to, resource) 
      if (entries.size == 0 || entries.first.date != from) && (entry = get_resource_entry_before(from, resource)) != nil
        returnEntries << entry
      end
      entries.each do |entry|
        returnEntries << entry
      end
      if (entries.size == 0 || entries.last.date != last) && (entry = get_resource_entry_after(to, resource)) != nil
        returnEntries << entry
      end
      returnEntries
    end
    

    def self.get_chart_data(statistic_data, from, to)
      returnData = OpenStruct.new({"labels" => [], "costs" => []})
      if (hideEvery = ((to.to_date - from.to_date)/15).round) < 2 
        hideEvery = 1
      end
       
      sum = 0
      for i in 0...statistic_data.labels.size
        if (statistic_data.labels[i] >= from && statistic_data.labels[i] <= to)
          sum += statistic_data.costs[i]
          if statistic_data.labels[i] == from ##first entry always add
            returnData.labels << statistic_data.labels[i]
            returnData.costs   << (sum/hideEvery).round(2)
            sum = 0
          elsif (i+1) % hideEvery == 0
            returnData.labels << statistic_data.labels[i]
            returnData.costs   << (sum/hideEvery).round(2)
            sum = 0
          elsif statistic_data.labels[i] == to ## last entry which is not added
            returnData.labels << statistic_data.labels[i]
            returnData.costs   << (sum/((i+1)%hideEvery)).round(2)
          end
        end
      end
      returnData
    end

    def self.get_oldest_entryDate(resource)
        (resource.ressourceentries.sort!{|a,b| a.date <=> b.date}).last.date
    end




    def self.get_statistic_data (from,to, resource)   
      values = OpenStruct.new({"labels" => [], "costs" => [], "usages" => []})
      if from == nil || to == nil
        entries = resource.ressourceentries.sort! {|a,b| a.date <=> b.date}
      else
        entries = get_resource_entries_inkl_after_and_before(from, to, resource)
      end      #calc for all days
      for i in 1 ... entries.size
        entry = entries[i]
        prevEntry = entries[i-1]
        if (days = entry.date.to_date - prevEntry.date.to_date) == 1
          values.labels << entry.date.to_date
          values.costs  << ((entry.value - prevEntry.value)*resource.pricePerUnit).round(2)
          values.usages << entry.value - prevEntry.value
        else
          usage = (entry.value - prevEntry.value)/days
          costs =  ((entry.value - prevEntry.value)*resource.pricePerUnit)/days
          (prevEntry.date.to_date.tomorrow .. entry.date.to_date).each do |date|
            values.labels << date
            values.costs << costs.round(2)
            values.usages << usage
          end 
        end
      end
      values
    end

    def self.get_dashboard_data (statistic_data, resource, from, to)
      info = OpenStruct.new({name: "", unit: "", usage: "", cost:""})
      sum = 0
      if statistic_data.labels.size != 0
          for i in 0 ... (statistic_data.labels.size-1)
            if (statistic_data.labels[i] >= from && statistic_data.labels[i] <= to)
              sum += statistic_data.usages[i]
            end
          end
      end
      info.name = resource.name
      info.unit = resource.unit
      info.usage = sum.round(2)
      info.cost = (info.usage * resource.pricePerUnit + resource.monthlyCost + (resource.annualCost/12)).round(2)
      info
    end

    def self.get_overview_data (statistic_data, resource)
  		returnData = OpenStruct.new({general: [], years: []})
      if statistic_data.labels.size != 0
    		all = OpenStruct.new({name: I18n.t('activerecord.ressource.info_all'), usage: 0, costs: 0, firstEntry: nil, lastEntry: nil})
    		thisMonth = OpenStruct.new({name: I18n.t('activerecord.ressource.info_currentMonth'), usage: 0, costs: 0, firstEntry: nil, lastEntry: nil})
    		lastThreeMonth = OpenStruct.new({name: I18n.t('activerecord.ressource.info_lastthreemonths'), usage: 0, firstEntry: nil, lastEntry: nil})
    		currentYear = OpenStruct.new({name: statistic_data.labels[0].year, usage: 0, costs: 0, firstEntry: nil, lastEntry: nil})

    		for i in 0...statistic_data.labels.size
    			date = statistic_data.labels[i]
    			entry = statistic_data.usages[i]

    			 add_overview_entry(all, date, entry)
        		if date.year == Date.today.year && date.month == Date.today.month  # current month
        			add_overview_entry(thisMonth, date, entry)
        		end
        		if (date.year*12+date.month) >= (Date.today.year*12+Date.today.month-2)  # last three months
        			add_overview_entry(lastThreeMonth, date, entry)
        		end
        		if currentYear.firstEntry == nil || currentYear.lastEntry.year == date.year
        			add_overview_entry(currentYear, date, entry)
        		else
        			returnData.years << set_overview_costs(currentYear, resource)
        			currentYear = OpenStruct.new({name: date.year, usage: entry, costs: 0, firstEntry: nil, lastEntry: nil})
        		end
       	end

       	if (currentYear.firstEntry != nil)
       		returnData.years << set_overview_costs(currentYear, resource);
       	end  
       	
        if (thisMonth.firstEntry != nil)
       		returnData.general << set_overview_costs(thisMonth, resource);
       	end

     		if (lastThreeMonth.firstEntry != nil)
       		returnData.general << set_overview_costs(lastThreeMonth, resource);
     		end

        if (all.firstEntry != nil)
          returnData.general << set_overview_costs(all, resource);
        end
      end
    
    	returnData
    end

    def self.find_resource_with_user_constraint(id, user)
        Ressource.where(id: id, flat_id: user.flat.id).first
    end

    # setAttributes to all resources before get response
    def self.set_attributes(resources)
      for resource in resources
        resource.entryLength = resource.ressourceentries.size
        res = resource.ressourceentries.sort! {|a,b| a.date <=> b.date}
        resource.chartDateRange = OpenStruct.new({startDate: res.first.date, endDate: res.last.date})
        if get_month_diff(res.first.date, res.last.date) > 12
          resource.chartDateRange.startDate = Date.new(res.last.date.year-1, res.last.date.month, res.last.date.day)
        end
      end
    resources
    end

    
    def self.add_overview_entry (overviewEntry, date, entry)
    	overviewEntry.usage += entry
    	if overviewEntry.firstEntry == nil
    		overviewEntry.firstEntry = date
    	end
    	overviewEntry.lastEntry = date
    end

    def self.set_overview_costs (overviewEntry, resource)
    	fixCostsPerMonth = resource.monthlyCost + resource.annualCost/12
    	overviewEntry.costs = (overviewEntry.usage * resource.pricePerUnit)
      overviewEntry.costs += fixCostsPerMonth * (1+get_month_diff(overviewEntry.firstEntry, overviewEntry.lastEntry))
    	overviewEntry.costs = overviewEntry.costs.round(2);
      overviewEntry.usage = overviewEntry.usage.round(2)
      overviewEntry
    end

    


    def self.calc(resource)
	    re = (resource.ressourceentries.sort! {|a,b| b.date <=> a.date})
	    for index in 0 ... re.size
	    	entry = re[index]
  			if entry.isFirst
	    		entry.usage = 0
	   			entry.costs = 0
	    	else
	    		entry.usage = (entry.value - re[index+1].value).round(2)
	    		entry.costs = (entry.usage * resource.pricePerUnit).round(2)
	    	end
		  end
		  re
    end
end