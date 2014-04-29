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
	
end
