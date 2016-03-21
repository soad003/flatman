class Shareditem < ActiveRecord::Base
  belongs_to	:flat

  # allow strange parameters for image loading
  attr_accessor :imageContent, :imagePath, :imageData

  validates :name, :flat, presence: true

  ### image validation functions
  has_attached_file :image,
                    styles: { thumb: '100x100', medium: '300x300' },
                    default_url: 'missing.svg'
  validates_attachment :image,
                       content_type: { content_type:  ['image/jpg',
                                                       'image/jpeg',
                                                       'image/gif',
                                                       'image/png']
                                     }
  validates_attachment_file_name :image, matches: [/png\Z/, /jpe?g\Z/, /gif\Z/]

  # to get the full image url
  def as_json(_options = {}) {
    id: id,
    description: description,
    tags: tags,
    name: name,
    hidden: hidden,
    available: available,
    sharingNote: sharingNote,
    image: image.url,
    thumb: image.url(:thumb),
    medimage: image.url(:medium)
  }
  end

  def self.which_contain(query)
    query = "%#{query}%".downcase
    where('(lower(shareditems.name) like ? or '\
          'lower(shareditems.tags) like ? or '\
          'lower(shareditems.description) like ?) and '\
          'shareditems.hidden = false', query, query, query)
  end

  def self.from_city(zip, city)
    Shareditem.joins(:flat).where('flats.city like ? or zip = ?', city, zip)
  end
end
