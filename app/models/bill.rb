class Bill < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to 				:billcategory
	belongs_to 				:user 
	
  	validates :date, presence: true
  	validates :value, presence: true

	def self.destroy_with_user_constraint(id,user)
		#entry = Bill.where(id: id, flat_id: user.flat.id)
		#entry.destroy!
	end
	
	
	def self.get_payees(bills, user)
		returnList = []
		bills.each do |b|
			if b.user_id == user.id
				returnList << b
			end
		end
		returnList
	end

	def self.get_payers(bills, user)
		returnList = []
		bills.each do |b|
			#if b.payerOne == user.id
			#	returnList << b
			#end
			#if b.payerTwo == user.id
			#	returnList << b
			#end
			#if b.payerThree == user.id
			#	returnList << b
			#end
			#if b.payerFour == user.id
			#	returnList << b
			#end
		end
	end

	def self.get_values_of_debts(payee, payer)

	end
end
