class Invite < ActiveRecord::Base
    validates   :email, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    belongs_to  :flat

    def self.find_by_email(email)
        find_by email: email
    end

    def self.find_with_user_constraint(id, user)
        where(id: id, flat_id: user.flat.id).first
    end
end
