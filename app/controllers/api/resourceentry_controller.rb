class Api::ResourceentryController < Api::RestController

    def create
        entry=Ressourceentry.new(entry_params)
        r = Ressource.find_resource_with_user_constraint(params[:resource_id], current_user)
        r.ressourceentries << entry
        r.save!
        respond_with(entry, :location => nil)
    end

    def destroy
        Ressourceentry.destroy_with_user_constraint(params[:id],params[:resource_id],current_user)
        respond_with(nil)
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
          params.require(:resourceentry).permit(:date,:value);
    end

end
