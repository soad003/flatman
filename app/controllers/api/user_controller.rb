class Api::UserController < Api::RestController

    def index
        @user=current_user
    end

end
