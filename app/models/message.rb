class Message < ActiveRecord::Base
	belongs_to	:sender, :class_name => 'User'
	belongs_to 	:receiver, :class_name => 'User'

	def self.find_chat(id, user)
        mesL = Message.where(sender_id: user.id)
        mesL2 = Message.where(receiver_id: user.id)
        mesL+mesL2
    end

end
