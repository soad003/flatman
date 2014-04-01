class Api::FlatController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:update]

    def index
        @flat=current_user.flat
    end

    def create
        if current_user.flat.nil?
            flat=Flat.new(flat_params)
            flat.save!
            current_user.flat = flat
            current_user.save!
            respond_with(flat, :location => api_flat_path(flat))
        else
            respond_with_errors([t('.already_in_flat')])
        end
    end

    def update
        flat = current_user.flat
        flat.update_attributes!(flat_params)
        respond_with(flat, :location => api_flat_path(flat))
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def flat_params
        params.require(:flat).permit(:name, :street, :city, :zip)
    end
end
