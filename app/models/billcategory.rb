class Billcategory < ActiveRecord::Base
  belongs_to	:flat
  has_many	:bills
  validates :name, :flat_id, presence: true

  def self.new_or_existing(cat_name, flat)
    cat_name = '-' if cat_name.blank?
    cat = where(['name = ? and flat_id = ?', cat_name, flat.id]).first
    cat.nil? ? Billcategory.new(name: cat_name, flat_id: flat.id) : cat
  end
end
