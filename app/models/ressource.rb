class Ressource < ActiveRecord::Base
		belongs_to	:flat
		has_many	:ressourceentries
		attr_accessor :entryLength

	def self.find_resource_with_user_constraint(id, user)
        Ressource.where(id: id, flat_id: user.flat.id).first
    end

    def self.setEntryLength(resources)
		for index in 0 ... resources.size
			resources[index].entryLength = resources[index].ressourceentries.size 
		end
		resources
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
