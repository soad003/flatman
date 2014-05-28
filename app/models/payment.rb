class Payment < ActiveRecord::Base
	belongs_to :payer, :class_name => 'User'
	belongs_to :payee, :class_name => 'User'
	validates  :payer_id, :payee_id, presence: true
    validates :value, numericality: {greater_than: 0}, presence: true

end
