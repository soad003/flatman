class Api::UserController < Api::RestController

    def index
        @user=current_user
    end


    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:task).permit(:item_name)
    end

end
