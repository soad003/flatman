class Ressource < ActiveRecord::Base
		belongs_to	:flat
		has_many	:ressourceentries

	def self.find_resource_with_user_constraint(id, user)
        Ressource.where(id: id, flat_id: user.flat.id).first
    end

    def self.calc(resources)

	    for i in 0 ... resources.size
	    	re = resources[i].ressourceentries.sort! {|a,b| b.date <=> a.date}
	    	for j in 0 ... re.size
	    		entry = re[j]
	    		if entry.isFirst == true
	    			entry.usage = 0
	    			entry.costs = 0
	    		else
	    			entry.usage = entry.value - re[j+1].value
	    			entry.costs = entry.usage * resources[i].pricePerUnit
	    		end
	   		end
	    end
	    
	    resources
    end
end
