class Flat < ActiveRecord::Base
	has_many	:users
	has_many 	:billcategories
	has_many 	:shareditems
	has_many	:shoppinglists
	has_many 	:ressources
    has_many    :invites
    validates   :name, :street, :city, :zip, presence: true
end
