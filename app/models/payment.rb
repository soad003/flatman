class Payment < ActiveRecord::Base
	belongs_to :payer, :class_name => 'User'
	belongs_to :payee, :class_name => 'User'
    belongs_to :flat
	validates  :payer_id, :payee_id, :flat_id, presence: true
    validates :value, numericality: {greater_than: 0}, presence: true

    def is_editable?
        !flat.nil? && 
        !payer.flat.nil? && 
        !payee.flat.nil? && 
        payer.flat.id == flat_id && 
        payee.flat.id == flat_id
    end

    def self.find_with_user_constraint(id, user1, user2)
    	payment = find_by(id: id)
    	if ((payment.payer_id == user2.id && payment.payee_id == user1.id)) #|| 
    		#(payment.payer_id == user2.id && payment.payee_id == user1.id))
    		payment
    	end
    end

end
