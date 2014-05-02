class Shareditem < ActiveRecord::Base
	belongs_to 	:flat
	attr_accessor :imageContent, :imagePath, :imageData

	### image validation functions
  has_attached_file :image, styles: {thumb: "200x200"}
  #validates :userIcon, :attachment_presence => true
  validates_attachment :image, :content_type => { :content_type => ["image/jpg", "image/gif", "image/png"] }
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  
  def as_json(options={})
    { 
      id: self.id,
      description: self.description,
      tags: self.tags,
      name: self.name, 
      hidden: self.hidden,
      available: self.available,
      image: self.image.url
    }
  end

  def self.which_contain(query)
      query="%#{query}%"
      where("(name like ? or description like ?)", query, query)
  end

end
