class Api::ResourceController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy]

    def index
        @r=Ressource.setAttributes(current_user.flat.ressources)
        #logic model calc call
        #respond_with(current_user.flat.ressources)
    end

    def create
       flat=current_user.flat
       r=Ressource.new(r_params)
       r.flat = flat
       r.save!
       re=Ressourceentry.new(ressource_id:r.id,date:r.startDate,value:r.startValue,isFirst:true)
       r.ressourceentries << re
       r.save!
       respond_with(nil, :location => nil);
    end

    def getChart
      resource = current_user.flat.ressources.where(id:params[:resource_id]).first

      #define ranges for calc
      dateFrom = DateTime.parse(params[:from])
      #dateFrom = DateTime.new(dateFrom.year, dateFrom.month, 1)
      dateTo = DateTime.parse(params[:to])
      #dateTo = DateTime.new(dateTo.year, dateTo.month, -1)
      respond_with(Ressource.getChartData(dateFrom, dateTo, resource))
    end

    def getOverview
      resource = current_user.flat.ressources.where(id:params[:resource_id]).first

      #define ranges for calc
      dateFrom = DateTime.parse(params[:from])
      dateTo = DateTime.parse(params[:to])
      @overview = Ressource.getOverviewData(dateFrom, dateTo, resource)
    end

    def getById
        respond_with(current_user.flat.ressources.where(id:params[:resource_id]).first)
    end

    def update
        r = Ressource.find_resource_with_user_constraint(params[:id], current_user)
        r.update_attributes!(r_params)
        re_first = r.ressourceentries.where(:isFirst => true).first()
        re_first.date = r.startDate
        re_first.value = r.startValue
        re_first.save!
        respond_with(r, :location => nil)
    end

    def destroy
        r = Ressource.find_resource_with_user_constraint(params[:id], current_user)
        r.destroy!  
        respond_with(nil)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def r_params
      params.require(:resource).permit(:name, :description, :monthlyCost, :pricePerUnit,:startDate,:annualCost, :startValue,:unit)
    end
end
