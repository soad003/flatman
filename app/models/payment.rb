class Payment < ActiveRecord::Base
		belongs_to :payer, :class_name => 'User'
	belongs_to :payee, :class_name => 'User'


	def self.get_users_payments(user)
		returnList = []
		payments = Payment.all
		payments.each do |p|
			if p.payer_id == user.id
				returnList << p
			end
			if p.payee_id == user.id
				returnList << p
			end
		end
		returnList
	end
end
