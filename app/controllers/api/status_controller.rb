class Api::StatusController < Api::RestController
    @@counter = 0
    def index
    	@@counter = 0
        header = "flatchat" + current_user.flat_id.to_s
        chatList = Message.find_chats(current_user)
        messList = []
        lastMessOfeachChat = []
        chatList.each do |chat|
        	messList = Message.find_messages(chat.id, current_user)
            messList.sort! { |a,b| a.created_at <=> b.created_at }
            if !messList.last.read
                lastMessOfeachChat << messList.last
            end 
        	@@counter = @@counter + (Message.countUnread(messList, current_user)).to_i
        end


        flatChatList = Message.where("header = ?", header)
        flatChatList.sort! { |a,b| a.created_at <=> b.created_at }
        flatcounter = (Message.countFlatChatUnread(flatChatList, current_user)).to_i
        @@counter = @@counter + flatcounter

        respond_with({unread_messages:@@counter, flat_messages: flatChatList.last, chats: lastMessOfeachChat})
    end

end
