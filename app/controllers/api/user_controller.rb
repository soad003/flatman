class Api::UserController < Api::RestController

    def index
        @user=current_user
    end

    def find
    	# find receiverlist for suggestions
	end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      #params.require(:task).permit(:item_name)
    end

    def recv_params
    	params.permit(:name)
    end

end
