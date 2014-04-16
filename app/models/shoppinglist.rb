class Shoppinglist < ActiveRecord::Base
	belongs_to 	:flat
	has_many	:shoppinglistitems
    validates   :name,:flat, presence: true

    def self.find_list_with_user_constraint(id, user)
        find_by!(id: id, flat_id: user.flat.id)
    end
end
