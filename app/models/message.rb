class Message < ActiveRecord::Base
	belongs_to	:sender, :class_name => 'User'
	belongs_to 	:receiver, :class_name => 'User'

	def self.find_messages(user, user2)
		mesL = Message.where(['sender_id = ? AND receiver_id = ?', user.id, user2])
        mesL2 = Message.where(['receiver_id = ? AND sender_id = ?', user.id, user2])
        #mesL = Message.where(sender_id: user.id)
        #mesL2 = Message.where(receiver_id: user.id)
        mesL+mesL2
    end

    def self.find_chats(user)
    	mesL = Message.where(sender_id: user.id)
       	mesL2 = Message.where(receiver_id: user.id)
        messList = mesL+mesL2
        # sort by newest
        messList.sort! { |a,b| b.created_at <=> a.created_at }
        # remove already displayed chats
        messList.each do |mes| 
      		#
    	end
    end

end
