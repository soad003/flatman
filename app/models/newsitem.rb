class Newsitem < ActiveRecord::Base
    enum category: [:message, :shoppinglist, :shoppinglistitem, :todolist, :todolistitem, :resource, :resourceitem, :bill, :payment]
    enum action: [:add, :change, :remove]

    attr_accessor :header
    attr_accessor :image

	belongs_to 				:user
	belongs_to              :flat
	has_many                :newsitems
	belongs_to				:newsitem
	validates   :user, :flat, presence: true

    def self.createShoppinglist(shoppinglist, user)
        Newsitem.saveNewsitem(user, categories[:shoppinglist], actions[:add], shoppinglist.id, shoppinglist.name)
    end

    def self.deleteShoppinglist(shoppinglist, user)
        Newsitem.saveNewsitem(user, categories[:shoppinglist], actions[:remove], nil, shoppinglist.name)
    end

    def self.createShoppinglistitem(shoppinglistitem, user)
        Newsitem.saveNewsitem(user, categories[:shoppinglistitem], actions[:add], shoppinglistitem.id, shoppinglistitem.name)
    end

    def self.createMessage(text, user)
        Newsitem.saveNewsitem(user, categories[:message], actions[:add], nil, text)
    end

    def self.createBill(bill, user)
        Newsitem.saveNewsitem(user, categories[:bill], actions[:add], bill.id, bill.text)
    end

    def self.updateBill(bill, user)
        Newsitem.saveNewsitem(user, categories[:bill], actions[:change], bill.id, bill.text)
    end

    def self.deleteBill(bill, user)
        Newsitem.saveNewsitem(user, categories[:bill], actions[:remove], nil, bill.text)
    end

    def self.createPayment(payment, user)
        Newsitem.saveNewsitem(user, categories[:payment], actions[:add], payment.id, payment.payer.name)
    end

    def self.deletePayment(payment, user)
        Newsitem.saveNewsitem(user, categories[:payment], actions[:remove], nil, payment.payer.name)
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
    end

    def self.generateNewsfeed(user)
        newsitems = user.flat.newsitems.order(created_at: :desc)
        newsitems.each do |newsitem|
            newsitem.header = Newsitem.getHeader(newsitem)
            newsitem.text = Newsitem.getText(newsitem)
            newsitem.image = Newsitem.getImage(newsitem)
        end
        newsitems
    end

    def self.getImage(ni)
        if ni[:category] == categories[:message] then
            return ni.user.image_path
        elsif [categories[:payment], categories[:bill]].include? ni[:category] then
            return "finance"
        elsif [categories[:shoppinglistitem], categories[:shoppinglist]].include? ni[:category] then
            return "shopping"
        elsif [categories[:resource], categories[:resourceitem]].include? ni[:category] then
            return "resource"
        end
    end

    def self.getText(ni)
        if ni[:category] == categories[:message] then
            return ni.text
        end
        return ""
    end

    def self.getHeader(ni)
        if categories[:shoppinglist] == ni[:category] then
            return I18n.t('activerecord.newsitem.shoppinglist', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif categories[:bill] == ni[:category] then
            return I18n.t('activerecord.newsitem.bill', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif categories[:payment] == ni[:category] and actions[:add] == ni[:action] then
            return I18n.t('activerecord.newsitem.payment', :name => ni.text, :action => I18n.t('activerecord.newsitem.got'))
        end
        return ''
    end

end
