class Bill < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to 				:billcategory
	belongs_to 				:user 


	def self.calc()
		#for i in 0 ... resources.size
	    #	re = resources[i].ressourceentries.sort! {|a,b| b.date <=> a.date}
	    #	for j in 0 ... re.size
	    #		entry = re[j]
	    #		if entry.isFirst == true
	    #			entry.usage = 0
	    #			entry.costs = 0
	    #		else
	    #			entry.usage = entry.value - re[j+1].value
	    #			entry.costs = entry.usage * resources[i].pricePerUnit
	    #		end
	   	#	end
	    #end
	end
end
