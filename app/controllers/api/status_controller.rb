class Api::StatusController < Api::RestController
    @@counter = 0
    def index
        @@counter+=1
        respond_with({unread_messages:@@counter})
    end

end
