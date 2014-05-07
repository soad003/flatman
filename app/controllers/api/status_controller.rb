class Api::StatusController < Api::RestController
    @@counter = 0
    def index
    	@@counter = 0
        chatList = Message.find_chats(current_user)
        messList = []
        chatList.each do |chat|
        	messList = Message.find_messages(chat.id)
        	@@counter = @@counter + (Message.countUnread(messList, current_user)).to_i
        end
        
        respond_with({unread_messages:@@counter})
    end

end
