class Shoppinglistitem < ActiveRecord::Base
        acts_as_paranoid

		belongs_to	:user
		belongs_to 	:shoppinglist
        validates   :name, :shoppinglist, :user,  presence: true
        validates   :checked, :inclusion => { :in => [true, false] }

        def self.destroy_with_user_constraint(id, sl_id, user)
            item = Shoppinglistitem.find_with_user_constraint(id, sl_id ,user)
            item.destroy!
        end

        def self.find_with_user_constraint(id,sl_id,user)
            sl = Shoppinglist.find_list_with_user_constraint(sl_id, user)
            sl.shoppinglistitems.select{ |i| i.id == id.to_i }.first unless sl.nil?
        end

end
