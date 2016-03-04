class Newsitem < ActiveRecord::Base

    attr_accessor :header, :imagetype, :date, :link

    CATEGORIES = {message: [0, 'add'], shoppinglist:[1, 'shoppinglist'], shoppinglistitem:[2, 'shoppinglistitem'], todolist:[3, 'todolist'], todolistitem:[4, 'todolistitem'], resource:[5, 'resource'], resourceitem:[6, 'resourceitem'], bill:[7, 'bill'], payment:[8, 'payment']}
    ACTIONS = {add: [0, 'add'], change: [1,'change'], remove: [2,'remove']}



	belongs_to 				:user
	belongs_to              :flat
	has_many                :newsitems, -> { order 'created_at asc' },  :dependent => :destroy
	belongs_to				:newsitem
	validates   :user, :flat, presence: true

    def self.destroy_with_user_constraint(id, user)
        msg = Newsitem.find_with_user_constraint(id,user)
        msg.destroy!
    end

    def self.find_with_user_constraint(id, user)
        find_by!(id: id, user_id: user.id, flat_id: user.flat.id)
    end

    def self.createShoppinglist(shoppinglist, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:add], shoppinglist.id, shoppinglist.name)
    end

    def self.deleteShoppinglist(shoppinglist, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:remove], nil, shoppinglist.name)
        Newsitem.clearShoppingListID(shoppinglist, user)
    end

    def self.clearShoppingListID(shoppinglist, user)
        Newsitem.where(key: shoppinglist.id, category: Newsitem::CATEGORIES[:shoppinglistitem][0]).update_all(key: nil)
    end

    def self.createShoppinglistitem(shoppinglistitem, user)
        newsitem = Newsitem.getNewsitem(shoppinglistitem.shoppinglist.id, Newsitem::CATEGORIES[:shoppinglistitem], Newsitem::ACTIONS[:add], user)
        if newsitem.nil? then
            Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglistitem], Newsitem::ACTIONS[:add], shoppinglistitem.shoppinglist.id, shoppinglistitem.name)
        else
            newsitem.text = (newsitem.text  + ", " + shoppinglistitem.name).strip
            newsitem.save!
        end
    end

    def self.getNewsitem(key, category, action, user)
        Newsitem.where(key: key, category: category[0], user: user, flat: user.flat, action: action[0], updated_at: (DateTime.current - 10.minutes) ..  DateTime.current).take
    end

    def self.createMessage(text, user)
        newsitem = Newsitem.where(category: Newsitem::CATEGORIES[:message][0], flat: user.flat, action: Newsitem::ACTIONS[:add][0], updated_at: (DateTime.current - 20.seconds) ..  DateTime.current).order(updated_at: :desc).first
        if !newsitem.nil? and newsitem.user.id == user.id then
            newsitem.text = (newsitem.text  + " " + text).strip
            newsitem.save!
        else
           Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:message], Newsitem::ACTIONS[:add], nil, text)
        end
        push = PushBot::Push.new(user.device_token, :android)
        push.notify('Hello and Welcome to the App!')
    end

    def self.createBill(bill, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:bill], Newsitem::ACTIONS[:add], bill.id, bill.text)
    end

    def self.updateBill(bill, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:bill], Newsitem::ACTIONS[:change], bill.id, bill.text)
    end

    def self.deleteBill(bill, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:bill], Newsitem::ACTIONS[:remove], nil, bill.text)
    end

    def self.createPayment(payment, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:payment], Newsitem::ACTIONS[:add], payment.id, payment.payer.name)
    end

    def self.deletePayment(payment, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:payment], Newsitem::ACTIONS[:remove], nil, payment.payer.name)
    end

    def self.saveNewsitem(user, category, action, key, text)
        ni=Newsitem.new()
        ni.user = user
        ni.flat = user.flat
        ni.category = category[0]
        ni.action = action[0]
        if !key.nil? then ni.key = key end
        if !text.nil? then ni.text = text end
        ni.save!
    end

    def self.getActionText(i)
        Newsitem::ACTIONS.each do |key, array|
            if array[0] == i then return array[1] end
        end
        return ""
    end
end
