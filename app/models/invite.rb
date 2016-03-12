class Invite < ActiveRecord::Base
	include Tokenable

    validates   :email, :format => { :with => /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
    validates   :flat, :token, presence: true
    belongs_to  :flat

    def self.create_invite_from_email(email, current_user)
        invite=Invite.new()
        invite.email=email
        current_user.flat.invites << invite
        invite.save!
        return invite
    end

    def self.find_by_email(email)
        find_by email: email
    end

    def self.find_by_token(token)
        find_by token: token if !token.nil?
    end

    def self.find_with_user_constraint(id, user)
        find_by!(id: id, flat_id: user.flat.id)
    end
end
