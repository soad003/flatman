class Bill < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to 				:billcategory
	belongs_to 				:user

  	validates :date,:text,:user, presence: true
  	validates :value, numericality: true, presence: true
  	validates :users, length: { minimum: 1 }
  	validates_associated :billcategory, :message => nil

	def self.destroy_with_user_constraint(id,user)
		b=Bill.joins(:user).select('bills.*').where('bills.id=? and users.flat_id=?',id,user.flat_id).first
		b.billcategory.destroy! if b.billcategory.bills.count == 1
		b.destroy!
	end

	def self.find_bill_with_user_constraint(id)
		Bill.where(:id => id).first
	end
	
	def self.new_with_params(p, cat, flat)
		Bill.new().tap { |b|
			b.text = p[:text]
			b.date = Date.parse(p[:date])
			b.value = p[:value]
			b.user_id = p[:user_id]
			b.billcategory = cat
			b.users = p[:user_ids].map {|id| User.find_with_flat_constraint(id,flat)}
		}
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
