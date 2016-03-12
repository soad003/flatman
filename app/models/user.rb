class User < ActiveRecord::Base
    has_and_belongs_to_many :bills, -> { order 'date desc' }
    belongs_to  :flat
    has_many    :paidBills, :class_name => 'Bill', :foreign_key => 'user_id'
    has_many    :shoppinglistitems, -> { order 'created_at asc' }
    has_many    :sentMessages, :class_name => 'Message', :foreign_key => 'sender_id'
    has_many    :receivedMessages, :class_name => 'Message', :foreign_key => 'receiver_id'
    has_many    :paidPayments, :class_name => 'Payment', :foreign_key => 'payer_id'
    has_many    :receivedPayments, :class_name => 'Payment', :foreign_key => 'payee_id'
    has_many    :newsitems
    validates   :provider, :uid, :name, :oauth_token, :email, presence: true

    def has_flat?()
        !self.flat.nil?
    end

    def self.find_by_email(email)
        find_by email: email
    end

    def self.find_with_flat_constraint(id, flat)
        find_by(id: id, flat_id: flat.id)
    end

    def set_device(device_token)
      User.where(device_token: device_token).to_a.select { |user| user.id != self.id }.each do |user|
                                                          user.device_token = nil
                                                          user.save!
                                                        end
      self.device_token=device_token
      self.save!
    end

    def logout(is_app_user)
        #self.oauth_token = nil
        self.device_token = nil if is_app_user
        self.save!
    end

    def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |user|
            user.provider = auth.provider
            user.uid = auth.uid
            user.name = auth.info.name
            user.oauth_token = auth.credentials.token
            user.oauth_expires_at = Time.at(auth.credentials.expires_at)
            user.image_path = auth.info.image
            user.email = auth.info.email
            user.save!
        end
    end
end
