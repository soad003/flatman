class Bill < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to 				:billcategory
	belongs_to 				:user 
  	#validates :billcategory, presence: true
  	#validates :value, presence: true

	def self.set_attributes(finances)
		for finance in finances
			finance.entryLength = finance.financentries.size
			fin = finance.financeentries.sort! {|a,b| a.date <=> b.date}
			#not finished, edit
		end
	end

	def self.find_financial_with_user_constraint(id,user)
		Bill.where(id: id, flat_id: user.flat.id).first
	end

	
end
