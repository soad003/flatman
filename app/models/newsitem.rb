class Newsitem < ActiveRecord::Base
    attr_accessor :header, :image

    CATEGORIES = {message: [0, 'add'], shoppinglist:[1, 'shoppinglist'], shoppinglistitem:[2, 'shoppinglistitem'], todolist:[3, 'todolist'], todolistitem:[4, 'todolistitem'], resource:[5, 'resource'], resourceitem:[6, 'resourceitem'], bill:[7, 'bill'], payment:[8, 'payment']}
    ACTIONS = {add: [0, 'add'], change: [1,'change'], remove: [2,'remove']}



	belongs_to 				:user
	belongs_to              :flat
	has_many                :newsitems
	belongs_to				:newsitem
	validates   :user, :flat, presence: true

    def self.createShoppinglist(shoppinglist, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:add], shoppinglist.id, shoppinglist.name)
    end

    def self.deleteShoppinglist(shoppinglist, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:remove], nil, shoppinglist.name)
    end

    def self.createShoppinglistitem(shoppinglistitem, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglistitem], Newsitem::ACTIONS[:add], shoppinglistitem.shoppinglist.id, shoppinglistitem.name)
    end

    def self.createMessage(text, user)
        Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:message], Newsitem::ACTIONS[:add], nil, text)
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

    def self.generateNewsfeed(user)
        newsitems = user.flat.newsitems.order(created_at: :desc)
        nisGroupedByItems = []
        
        newsitems.each do |newsitem|
            newsitem.header = Newsitem.getHeader(newsitem)
            newsitem.text = Newsitem.getText(newsitem)
            newsitem.image = Newsitem.getImage(newsitem)
        end
        newsitems
    end

    def self.getImage(ni)
        if ni[:category] == Newsitem::CATEGORIES[:message][0] then
            return ni.user.image_path
        elsif [Newsitem::CATEGORIES[:payment][0], Newsitem::CATEGORIES[:bill][0]].include? ni[:category] then
            return "finance"
        elsif [Newsitem::CATEGORIES[:shoppinglistitem][0], Newsitem::CATEGORIES[:shoppinglist][0]].include? ni[:category] then
            return "shopping"
        elsif [Newsitem::CATEGORIES[:resource][0], Newsitem::CATEGORIES[:resourceitem][0]].include? ni[:category] then
            return "resource"
        end
    end

    def self.getText(ni)
        if ni[:category] == Newsitem::CATEGORIES[:message][0] then
            return ni.text
        end
        return ""
    end

    def self.getHeader(ni)
        if Newsitem::CATEGORIES[:shoppinglist][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.shoppinglist', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        elsif Newsitem::CATEGORIES[:bill][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.bill', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        elsif Newsitem::CATEGORIES[:payment][0] == ni[:category] and Newsitem::ACTIONS[:add][0] == ni.action then
            return I18n.t('activerecord.newsitem.payment', :name => ni.text, :action => I18n.t('activerecord.newsitem.got'))
        elsif Newsitem::CATEGORIES[:shoppinglistitem][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.shoppinglistitem', :items => ni.text, :list => Shoppinglist.find_list_with_user_constraint(ni.key, ni.user).name, :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        end
        return ''
    end

    def self.getActionText(i)
        Newsitem::ACTIONS.each do |key, array|
            if array[0] == i then return array[1] end
        end
        return ""
    end

end
