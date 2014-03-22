class Shoppinglistitem < ActiveRecord::Base
		belongs_to	:user
		belongs_to 	:shoppinglist

        def self.destroy_with_user(sl_id, id, user)
            sl = Shoppinglist.find_list_with_user(sl_id,user)
            item = sl.shoppinglistitems.select{ |i| i.id == id.to_i }.first
            item.destroy!
        end
end
