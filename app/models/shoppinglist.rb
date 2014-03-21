class Shoppinglist < ActiveRecord::Base
	belongs_to 	:flat
	has_many	:shoppinglistitems
end
