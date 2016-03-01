class Newsitemcategory < ActiveRecord::Base
	has_many	:newsitems
	validates   :name, presence: true

	def self.getMessageCategory()
        Newsitemcategory.where(name:'message').first
    end

    def self.getShoppingCategory()
        Newsitemcategory.where(name:'shopping').first
    end

    def self.getFinanceCategory()
        Newsitemcategory.where(name:'finance').first
    end
end
