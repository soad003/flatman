class Shareditem < ActiveRecord::Base
	belongs_to 	:flat
	
	### image validation functions
  has_attached_file :userIcon, styles: {thumb: "100x100#"}
  #validates :userIcon, :attachment_presence => true
  validates_attachment :userIcon, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates_attachment_file_name :userIcon, :matches => [/png\Z/, /jpe?g\Z/]

    def self.which_contain(query)
        query="%#{query}%"
        where("(name like ? or description like ?)", query, query)
    end

end
