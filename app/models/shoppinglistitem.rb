class Shoppinglistitem < ActiveRecord::Base
		belongs_to	:user
		belongs_to 	:shoppinglist
        validates   :name, :shoppinglist, presence: true

        def self.destroy_with_user_constraint(id, sl_id, user)
            item = Shoppinglistitem.find_with_user_constraint(id, sl_id ,user)
            item.destroy!
        end

        def self.find_with_user_constraint(id,sl_id,user)
            sl = Shoppinglist.find_list_with_user_constraint(sl_id, user)
            sl.shoppinglistitems.select{ |i| i.id == id.to_i }.first unless sl.nil?
        end

end
