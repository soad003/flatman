class Api::UserController < Api::RestController

    def index
        respond_with(current_user)
    end


    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def shopping_list_params
      #params.require(:task).permit(:item_name)
    end

end
