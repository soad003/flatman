class Api::FlatController < Api::RestController

    def index
        respond_with(current_user.flat)
    end

    def create
        flat=Flat.new(flat_params)
        flat.users << current_user
        flat.save!
        respond_with(nil)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      #params.require(:task).permit(:item_name)
      params.permit(:name, :street, :city, :zip)
    end

end
