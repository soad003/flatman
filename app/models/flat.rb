class Flat < ActiveRecord::Base
	has_many	:users
	has_many 	:billcategories
	has_many 	:shareditems , -> { order 'name asc' }
	has_many	:shoppinglists, -> { order 'created_at asc' }
	has_many 	:resources
    has_many    :invites
    has_many    :bills
    has_many    :newsitems
    validates   :name, :street, :city, :zip, presence: true
    geocoded_by :full_street_address
    after_validation :geocode

    def add_user(user)
        user.flat = self
        user.save!
    end

    def users_involved
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
end
