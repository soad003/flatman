class Api::StatusController < Api::RestController

    def index
    	counter = 0
        msgIdChanged = []
        header = "flatchat" + current_user.flat_id.to_s
        chatList = Message.find_chats(current_user)
        messList = []
        lastMessOfeachChat = []
        chatList.each do |chat|
        	messList = Message.find_messages(chat.id, current_user)
            messList.sort! { |a,b| a.created_at <=> b.created_at }
            if messList.length > 1
                if !messList.last.read
                    lastMessOfeachChat << messList.last
                    msgIdChanged << messList.last.id
                # two people write at the same time
                elsif !messList.at(messList.length - 1).read
                    lastMessOfeachChat << messList.at(messList.length -1)
                    msgIdChanged << messList.at(messList.length - 1).id
                end
            end
        	counter = counter + (Message.countUnread(messList, current_user)).to_i
        end


        flatChatList = Message.where("header = ?", header)
        flatChatRetList = Array.new
        flatChatList.each do |mes| 
            if !mes.readers.include?(current_user.id)
                flatChatRetList << mes
                msgIdChanged << mes.id
            end
        end
        flatChatList.sort! { |a,b| a.created_at <=> b.created_at }
        flatcounter = (Message.countFlatChatUnread(flatChatList, current_user)).to_i
        counter = counter + flatcounter

        respond_with({unread_messages:counter, flat_messages: flatChatRetList, chats: lastMessOfeachChat, msg_id: msgIdChanged})
    end

end
