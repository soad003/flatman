class Shareditem < ActiveRecord::Base
	belongs_to 	:flat

    def self.which_contain(query)
        query="%#{query}%"
        where("(name like ? or description like ?)", query, query)
    end

end
