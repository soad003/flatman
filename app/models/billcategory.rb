class Billcategory < ActiveRecord::Base
	belongs_to	:flat
	has_many		:bills
  #accepts_nested_attributes_for :billcategory




	def self.check_unique(billcat, category)
     id = 0;
		  billcat.each do |b|
          if b.name == category.name
            id = b.id
            #entry.destroy!
          end
      end
      id
  end

 # def self.merge_value(bills, category)
  #  returnList = []
   # category.each do |c|
    #  bills.each do |b|
     #   if c.id == b.category_id


  #end

end
