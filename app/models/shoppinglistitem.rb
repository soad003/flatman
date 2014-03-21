class Shoppinglistitem < ActiveRecord::Base
		belongs_to	:user
		belongs_to 	:shoppinglist
end
