class Flat < ActiveRecord::Base
	has_many	:users
	has_many 	:billcategories
	has_many 	:shareditems
	has_many	:shoppinglists, -> { order 'created_at asc' }
	has_many 	:resources
    has_many    :invites
    has_many    :bills
    validates   :name, :street, :city, :zip, presence: true
    geocoded_by :full_street_address
    after_validation :geocode

    def add_user(user)
        user.flat = self
        user.save!
    end

    def full_street_address
        if (self.zip != nil && self.city != nil && self.street != nil)
            self.zip + " " + self.city + ", " + self.street
        else
            ""
        end
    end

    def is_member?(user)
        users.any? {|u| u.id==user.id}
    end

    def self.create_with_user!(user, params)
        nf=Flat.new(params)
        nf.save!
        nf.add_user(user)
        nf
    end

    def get_distance_to(flat)
        eradius = 6378.137
        dist = -1
        if (flat != nil && flat.latitude != nil && flat.longitude != nil && self.longitude != nil && self.latitude != nil)
            dist = Math.acos(
                       Math.sin(flat.latitude/180*Math::PI)*Math.sin(self.latitude/180*Math::PI) +
                       Math.cos(flat.latitude/180*Math::PI)*Math.cos(self.latitude/180*Math::PI)*Math.cos(flat.longitude/180*Math::PI-self.longitude/180*Math::PI)
                    ) * eradius
        end
        dist
    end
end
