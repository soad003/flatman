class Flat < ActiveRecord::Base
	has_many	:users
	has_many 	:billcategories
	has_many 	:shareditems
	has_many	:shoppinglists
	has_many 	:ressources
    has_many    :invites
    validates   :name, :street, :city, :zip, presence: true

    def add_user(user)
        user.flat = self
        user.save!
    end

    def is_member?(user)
        users.any? {|u| u.id==user.id}
    end

    def self.create!(user, params)
        nf=Flat.new(params)
        nf.save!
        nf.add_user(user)
        nf
    end

end
