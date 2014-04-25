class Shareditem < ActiveRecord::Base
	belongs_to 	:flat
	has_one :upload

    def self.which_contain(query)
        query="%#{query}%"
        where("(name like ? or description like ?)", query, query)
    end

end
