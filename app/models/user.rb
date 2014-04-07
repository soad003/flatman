class User < ActiveRecord::Base
    has_and_belongs_to_many :bills
    belongs_to  :flat
    has_many    :paidBills, :class_name => 'Bill', :foreign_key => 'user_id'
    has_many    :shoppinglistitems
    has_many    :sentMessages, :class_name => 'Message', :foreign_key => 'sender_id'
    has_many    :receivedMessages, :class_name => 'Message', :foreign_key => 'receiver_id'
    has_many    :paidPayments, :class_name => 'Payment', :foreign_key => 'payer_id'
    has_many    :receivedPayments, :class_name => 'Payment', :foreign_key => 'payee_id'

    def has_flat?()
        !flat.nil?
    end

    def self.find_by_email(email)
        find_by email: email
    end

    def self.from_omniauth(auth)
        where(auth.slice(:provider,:uid)).first_or_initialize.tap do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.oauth_token = auth.credentials.oauth_token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.image_path = auth.info.image
            user.email = auth.info.email
            user.save!
        end

    end

end
