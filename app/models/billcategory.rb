class Billcategory < ActiveRecord::Base
	belongs_to	:flat
	has_many		:bills
end
