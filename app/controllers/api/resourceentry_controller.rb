class Api::ResourceentryController < Api::RestController

     def page
        #@r=Ressource.calc(current_user.flat.ressources);
        #logic model calc call
        r = Ressource.find_resource_with_user_constraint(params[:resource_id], current_user)
        @re = Ressource.calc(r, params[:page])
    end

    def create
        entry=Ressourceentry.new(entry_params)
        r = Ressource.find_resource_with_user_constraint(params[:resource_id], current_user)
        firstEntry = r.ressourceentries.where(isFirst:true).first
        if (firstEntry.date > entry.date)
            respond_with_errors([t('.entryDate_before_startDate')])
        elsif r.ressourceentries.where('date = ?', entry.date).all.count != 0
             respond_with_errors([t('.entryDate_exists')])
        else

            entry.ressource = r
            entry.save!
            respond_with(entry, :location => nil)
        end
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
