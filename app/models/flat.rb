class Flat < ActiveRecord::Base
	has_many	:users
	has_many 	:billcategories
	has_many 	:shareditems
	has_many	:shoppinglists, -> { order 'created_at asc' }
	has_many 	:resources
    has_many    :invites
    validates   :name, :street, :city, :zip, presence: true

    def add_user(user)
        user.flat = self
        user.save!
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
       point1 = self.zip + " " + self.city + ", " + self.street
       point2 = flat.zip + " " + flat.city + ", " + flat.street
       return Geocoder::Calculations.distance_between(point1, point2)
    end
  
end
