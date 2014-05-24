class Billcategory < ActiveRecord::Base
	belongs_to	:flat
	has_many		:bills
  validates   :name, :flat_id, presence: true

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

  def self.new_or_existing(cat_name,flat)
    cat_name = "-" if cat_name.blank?
    cat = where(['name = ? and flat_id = ?', cat_name, flat.id]).first
    if cat.nil? then Billcategory.new({name: cat_name ,flat_id: flat.id}) else cat end
  end

end
