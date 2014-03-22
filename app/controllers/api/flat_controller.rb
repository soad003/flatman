class Api::FlatController < Api::RestController

    def index
        respond_with(current_user.flat)
    end

    def create
        flat=Flat.new(flat_params)
        #flat.users << current_user
        flat.save!
        respond_with(flat, :location => api_flat_path(flat))
    end

    def show
        respond_with(Flat.find_by_id(params[:id]))
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
      params.require(:flat).permit(:name, :street, :city, :zip)
    end

end
