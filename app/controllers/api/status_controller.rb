class Api::StatusController < Api::RestController
    @@counter = 0
    def index
        chatList = Message.find_chats(current_user)
        @@counter = Message.countUnread(chatList, current_user)
        respond_with({unread_messages:@@counter})
    end

end
