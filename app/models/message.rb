class Message < ActiveRecord::Base
	belongs_to     	:sender, :class_name => 'User'
	belongs_to  	:receiver, :class_name => 'User'
    validates       :receiver_id, :text, presence: true

	def self.find_messages(mesId)
        user = Message.find(mesId).sender_id
        user2 = Message.find(mesId).receiver_id
		mesL = Message.where(sender_id: user, receiver_id: user2)
        mesL2 = Message.where(receiver_id: user, sender_id: user2)
        messList = mesL+mesL2
        messList.sort! { |a,b| a.created_at <=> b.created_at }
    end

    def self.find_partner(mesId, current_user)
        user = Message.find(mesId).sender_id
        user2 = Message.find(mesId).receiver_id
        if user == current_user.id
            retUser = user2
        else 
            retUser = user
        end
        User.find(retUser)
    end

    def self.find_chats(user)
    	# all messages with me as sender
        header = "flatchat" + user.flat_id.to_s
        mesL = Message.where("sender_id = ? AND header != ?", user.id, header)
        # all messages with me as receiver
       	mesL2 = Message.where("receiver_id = ? AND header != ?", user.id, header)
        messList = mesL.clone+mesL2.clone
        # sort by newest
        messList.sort! { |a,b| b.created_at <=> a.created_at }
        # create array with sender, receiver pair
        returnList = Array.new
        pairs = Array.new
        messList.each do |mes|
            if !(pairs.include?([mes.receiver_id, mes.sender_id]))
                    newpair = Array.new
                    newpair[0] = mes.sender_id
                    newpair[1] = mes.receiver_id
                    pairs << newpair
                    newpair2 = Array.new
                    newpair2[0] = mes.receiver_id
                    newpair2[1] = mes.sender_id
                    pairs << newpair2
            end
        end
        # remove old messages
        messList.each do |mes|
            if pairs.include?([mes.receiver_id, mes.sender_id])
                    returnList << mes
                    pairs.delete([mes.receiver_id, mes.sender_id])
                    pairs.delete([mes.sender_id, mes.receiver_id])
            end
        end

        returnList
    end

    def self.countUnread(counterList, current_user)
        count = "0"
        counterList.each do |c| 
            if c.read == false
                if c.sender_id != current_user.id
                    count = (count.to_i + 1).to_s
                end
            end
        end
        count
    end

    def self.countFlatChatUnread(counterList, current_user)
        count = "0"
        counterList.each do |c|
            if !c.readers.include?(current_user.id)
                count = (count.to_i + 1).to_s
            end
        end
        count
    end

end
