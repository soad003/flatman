class Newsitem < ActiveRecord::Base

    attr_accessor :header, :imagetype, :date, :link

    CATEGORIES = {message: 'message', useraction: 'useraction', shoppinglist: 'shoppinglist', shoppinglistitem: 'shoppinglistitem', todolist: 'todolist', todolistitem: 'todolistitem', resource: 'resourcelist', resourceitem: 'resourcelistitem', bill: 'bill', payment: 'payment'}
    ACTIONS = {add: 'add', change: 'change', remove: 'remove'}


	belongs_to              :user
	belongs_to              :flat
	has_many                :newsitems, -> { order 'created_at asc' },  :dependent => :destroy
	belongs_to				:newsitem
	validates   :user, :flat, presence: true

    def isFinance()                 isPayment() || isBill()                                         end
    def isPayment()                 self[:category] == Newsitem::CATEGORIES[:payment]               end
    def isBill()                    self[:category] == Newsitem::CATEGORIES[:bill]                 end
    def isShoppingList()            self[:category] == Newsitem::CATEGORIES[:shoppinglist]          end
    def isShoppingListItem()        self[:category] == Newsitem::CATEGORIES[:shoppinglistitem]      end
    def isShopping()                self.isShoppingList() || self.isShoppingListItem()              end
    def isTodoList()                self[:category] == Newsitem::CATEGORIES[:todolist]              end
    def isTodoListItem()            self[:category] == Newsitem::CATEGORIES[:todolistitem]          end
    def isTodo()                    self.isTodoList() || self.isTodoListItem()                      end
    def isResourceList()            self[:category] == Newsitem::CATEGORIES[:resourcelist]          end
    def isResourceListItem()        self[:category] == Newsitem::CATEGORIES[:resourcelistitem]      end
    def isResource()                self.isResourceList() || self.isResourceListItem()              end
    def isMessage()                 self[:category] == Newsitem::CATEGORIES[:message]               end
    def isUseraction()              self[:category] == Newsitem::CATEGORIES[:useraction]            end

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
        Newsitem.where(key: shoppinglist.id, category: Newsitem::CATEGORIES[:shoppinglistitem]).update_all(key: nil)
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

    def self.createTodolist(todolist, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:todolist], Newsitem::ACTIONS[:add], todolist.id, todolist.name)
    end

    def self.deleteTodolist(todolist, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:todolist], Newsitem::ACTIONS[:remove], nil, todolist.name)
        Newsitem.clearTodoListID(todolist, user)
    end

    def self.clearTodoListID(todolist, user)
        Newsitem.where(key: todolist.id, category: Newsitem::CATEGORIES[:todolistitem]).update_all(key: nil)
    end

    def self.createTodolistitem(todolistitem, user)
        newsitem = Newsitem.getNewsitem(todolistitem.todo.id, Newsitem::CATEGORIES[:todolistitem], Newsitem::ACTIONS[:add], user)
        if newsitem.nil? then
            Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:todolistitem], Newsitem::ACTIONS[:add], todolistitem.todo.id, todolistitem.name)
        else
            newsitem.text = (newsitem.text  + ", " + todolistitem.name).strip
            newsitem.save!
        end
    end

    def self.getNewsitem(key, category, action, user)
        Newsitem.where(key: key, category: category, user: user, flat: user.flat, action: action, updated_at: (DateTime.current - 10.minutes) ..  DateTime.current).take
    end

    def self.createMessage(text, user)
        newsitem = Newsitem.where(category: Newsitem::CATEGORIES[:message], flat: user.flat, action: Newsitem::ACTIONS[:add], updated_at: (DateTime.current - 20.seconds) ..  DateTime.current).order(updated_at: :desc).first
        if !newsitem.nil? and newsitem.user.id == user.id then
            newsitem.text = (newsitem.text  + " " + text).strip
            newsitem.save!
        else
           Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:message], Newsitem::ACTIONS[:add], nil, text)
        end
        push = PushBot::Push.new(user.device_token, :ios)
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

    def self.deleteUser(user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:useraction], Newsitem::ACTIONS[:remove], nil, nil)
    end

    def self.addUser(user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:useraction], Newsitem::ACTIONS[:add], nil, nil)
    end

    def self.saveNewsitem(user, category, action, key, text)
        ni=Newsitem.new()
        ni.user = user
        ni.flat = user.flat
        ni.category = category
        ni.action = action
        if !key.nil? then ni.key = key end
        if !text.nil? then ni.text = text end
        ni.save!
        #Thread.new {
            Newsitem.push(ni)
        #}
    end

    def self.getPushMessage(newsitem)
        if newsitem.isFinance() then return I18n.t('activerecord.newsitem.pushFinance', :name => newsitem.user.name) end
        if newsitem.isShopping() then return I18n.t('activerecord.newsitem.pushShopping', :name => newsitem.user.name) end
        if newsitem.isTodo() then return I18n.t('activerecord.newsitem.pushTodo', :name => newsitem.user.name) end
        if newsitem.isResource() then return I18n.t('activerecord.newsitem.pushResource', :name => newsitem.user.name) end
        if newsitem.isMessage() then return I18n.t('activerecord.newsitem.pushMessage', :name => newsitem.user.name) end
    end

    def self.push(newsitem)
        #pushlogic
        if Newsitem.sendPush(newsitem) then
            message = Newsitem.getPushMessage(newsitem)
            newsitem.user.flat.users.each do |mate|
                if (mate.id != newsitem.user.id and !(mate.device_token == '' or mate.device_token.nil?)) then
                    push = PushBot::Push.new(mate.device_token, :ios)
                    push.notify(message)
                    push = PushBot::Push.new(mate.device_token, :android)
                    push.notify(message)
                end
            end
        end
    end

    def self.sendPush(newsitem)
        true
    end

end
