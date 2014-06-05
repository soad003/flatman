class Message < ActiveRecord::Base
	belongs_to     	:sender, :class_name => 'User'
	belongs_to  	:receiver, :class_name => 'User'
    validates       :receiver_id, :text, presence: true

	def self.find_messages(mesId, current_user)
        retList = Array.new
        header = "flatchat" + current_user.flat_id.to_s
        if Message.find(mesId).header == header
            retList = Message.where("header = ?", header)
            retList.each do |m|
                if !m.readers.include?(current_user.id) 
                    m.readers = m.readers + [current_user.id]
                    m.save!
                end
            end
        else
            user = Message.find(mesId).sender_id
            user2 = Message.find(mesId).receiver_id
            mesL = Message.where("sender_id = ? AND receiver_id = ?", user, user2)
            mesL2 = Message.where("sender_id = ? AND receiver_id = ?", user2, user)
            messList = mesL+mesL2
            messList.each do |mes|
                if !mes.deleted.include?(current_user.id)
                    retList << mes
                end
            end
        end
        retList.sort! { |a,b| a.created_at <=> b.created_at }
    end

    def self.find_partner(mesId, current_user)
        user = Message.find(mesId).sender_id
        user2 = Message.find(mesId).receiver_id
        if user == current_user.id
            retUser = user2
        else 
            retUser = user
        end

        if user == user2
            ret = ({id: user, name: User.find(user).flat.name})
        else
            ret = ({id: retUser, name: User.find(retUser).name})
        end
    end

    def self.find_chats(user)
    	# all messages with me as sender
        header = "flatchat" + user.flat_id.to_s
        mesL = Message.where("sender_id = ? AND header != ?", user.id, header)
        # all messages with me as receiver
       	mesL2 = Message.where("receiver_id = ? AND header != ?", user.id, header)
        messList = mesL.clone+mesL2.clone
        helpList = Array.new
        
        messList.each do |mes| 
            if !mes.deleted.include?(user.id)
                helpList << mes
            end
        end
        # sort by newest
        helpList.sort! { |a,b| b.created_at <=> a.created_at }
        # create array with sender, receiver pair
        returnList = Array.new
        pairs = Array.new
        helpList.each do |mes|
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
        helpList.each do |mes|
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

    def self.getFlatChat(current_user)
        header = "flatchat" + current_user.flat_id.to_s
        @flatChat=Message.where("header = ?", header)
        @flatChat.sort! { |a,b| a.created_at <=> b.created_at }
        @lastFlatChat = @flatChat.last
        if @lastFlatChat == nil
          @lastFlatChat = Message.new({id: 0, sender_id: current_user.id, receiver_id: current_user.id, text: "start chating with your flat members", header: "0", created_at: 0})
        end
        @lastFlatChat
    end

    def self.createMessages(recIdArray, current_user, mes_params)
        @newMess = Array.new
        recIdArray.each do |rec|
            @mes=Message.new(mes_params)
            @mes.receiver_id = rec
            @mes.header = "";
            if rec == "flatchat"
              header = "flatchat" + current_user.flat_id.to_s
              @mes.header = header
              @mes.receiver_id = current_user.id
              @mes.sender_id = current_user.id
            end
            beginDate2014 = Time.new(2014,3,30,2,0)
            endDate2014 = Time.new(2014,10,26,3,0)
            beginDate2015 = Time.new(2015,3,29,2,0)
            endDate2015 = Time.new(2015,10,25,3,0)
            nowTime = Time.at(Time.now.to_i + 3600)
            if nowTime.between?(beginDate2014, endDate2014) || nowTime.between?(beginDate2015, endDate2015)
              @mes.created_at = Time.at(nowTime.to_i + 3600)
            else 
              @mes.created_at = nowTime
            end
            @mes.readers = [current_user.id]
            @mes.deleted = []
            current_user.sentMessages << @mes.clone
            @newMess << @mes.clone
        end
        current_user.save!
        @newMess
    end

    def self.destroyMessages(mess_id, current_user)
        recId = Message.find(mess_id).receiver_id
        senId = Message.find(mess_id).sender_id
        messages1 = Message.where(receiver_id: recId, sender_id: senId)
        messages2 = Message.where(sender_id: recId, receiver_id: senId)
        messages = messages1.clone + messages2.clone
        messages.each do |mess| 
          if !mess.deleted.include?(current_user.id)
            mess.deleted = mess.deleted + [current_user.id]
            mess.save!
          end

          if mess.deleted.size > 1
            mess.destroy
          end
        end
    end

end
