class Newsitem < ActiveRecord::Base
	belongs_to 				:user
	belongs_to              :flat
	belongs_to 				:newsitemcategory
	has_many                :newsitems
	belongs_to				:newsitem
	validates   :user, :flat, presence: true

    def self.createShoppinglist(name, user)
        ni=Newsitem.new()
        ni.header = "hat die Einkaufsliste '" + name + "' erstellt."
        ni.user = user
        ni.newsitemcategory = Newsitemcategory.getShoppingCategory()
        user.flat.newsitems << ni
        user.flat.save!
    end

    def self.createMessage(name, user)
        ni=Newsitem.new()
        ni.header = "hat die Einkaufsliste '" + name + "' erstellt."
        ni.user = user
        ni.newsitemcategory = Newsitemcategory.getShoppingCategory()
        user.flat.newsitems << ni
        user.flat.save!
    end


    def self.createBill(name, user)
        ni=Newsitem.new()
        ni.header = "hat die Rechnung '" + name + "' erstellt."
        ni.user = user
        ni.newsitemcategory = Newsitemcategory.getFinanceCategory()
        user.flat.newsitems << ni
        user.flat.save!
    end

end
