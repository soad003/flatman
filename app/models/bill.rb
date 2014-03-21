class Bill < ActiveRecord::Base
	has_and_belongs_to_many :users
	belongs_to 				:billcategory
	belongs_to 				:user 
end
