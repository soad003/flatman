class Shareditem < ActiveRecord::Base
	belongs_to 	:flat
	
	#allow strange parameters for image loading
	attr_accessor :imageContent, :imagePath, :imageData

  validates   :name, :flat, presence: true
  
	### image validation functions
  has_attached_file :image, styles: {thumb: "200x200"}, :default_url => "http://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg"
  validates_attachment :image, :content_type => { :content_type => ["image/jpg", "image/jpeg", "image/gif", "image/png"] }
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/, /gif\Z/]
  
  #to get the full image url
  def as_json(options={}) { 
      id: self.id,
      description: self.description,
      tags: self.tags,
      name: self.name, 
      hidden: self.hidden,
      available: self.available,
      sharingNote: self.sharingNote,
      image: self.image.url
    }
  end

  def self.which_contain(query)
      query="%#{query}%"
      where("(name like ? or tags like ?)", query, query)
  end

end
