class Shareditem < ActiveRecord::Base
	belongs_to 	:flat
	attr_accessor :imageContent, :imagePath, :imageData

	### image validation functions
  has_attached_file :image, styles: {thumb: "100x100#"}
  #validates :userIcon, :attachment_presence => true
  validates_attachment :image, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]


  def self.which_contain(query)
      query="%#{query}%"
      where("(name like ? or description like ?)", query, query)
  end

end
