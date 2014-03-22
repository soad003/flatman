class Shoppinglist < ActiveRecord::Base
	belongs_to 	:flat
	has_many	:shoppinglistitems

    def self.find_list_with_user(id,user)
        Shoppinglist.where(id: id, flat_id: user.flat.id).first
    end
end
