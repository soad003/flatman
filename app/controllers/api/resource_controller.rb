class Api::ResourceController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy]

    def index
        resources =Resource.set_attributes(current_user.flat.resources).sort! { |a,b| a.name.downcase <=> b.name.downcase }
        resources.each do |resource|
          resource.entries = Resource.calc(resource).drop(0).take(5)
          statistic = Resource.get_statistic_data(nil,nil,resource)
          resource.overview = Resource.get_overview_data(statistic, resource)
          resource.chart = Resource.get_chart_data(statistic, resource.chartDateRange.startDate, resource.chartDateRange.endDate)
        end
        @r = resources;
    end

    def create
       flat=current_user.flat
       r=Resource.new(r_params)
       r.flat = flat
       r.save!
       re=Resourceentry.new(resource_id:r.id,date:r.startDate,value:r.startValue,isFirst:true)
       r.resourceentries << re
       r.save!
       respond_with(nil, :location => nil);
    end

    def get_chart
      resource = current_user.flat.resources.where(id:params[:resource_id]).first
      #define ranges for calc add one day because javascript starts with 0 by days
      dateFrom = Date.parse(params[:from])
      dateTo = Date.parse(params[:to])
      statistic_data = Resource.get_statistic_data(dateFrom, dateTo, resource)
      @chart = Resource.get_chart_data(statistic_data, dateFrom, dateTo)
    end

    def get_overview
      resource = current_user.flat.resources.where(id:params[:resource_id]).first
      statistic_data = Resource.get_statistic_data(nil,nil,resource)
      @overview = Resource.get_overview_data(statistic_data, resource)
    end

    def dashboard
      resources = current_user.flat.resources
      returnList = []

      resources.each do |resource|
        oldestEntry = Resource.get_oldest_entryDate(resource)
        statistic_data = Resource.get_statistic_data(oldestEntry - 29, oldestEntry, resource)
        returnList << Resource.get_dashboard_data(statistic_data, resource, oldestEntry - 30, oldestEntry)
      end
      @dashboardList=returnList
    end

    def get_by_id
        respond_with(current_user.flat.resources.where(id:params[:resource_id]).first)
    end

    def update
        r = Resource.find_resource_with_user_constraint(params[:id], current_user)
        r.update_attributes!(r_params)
        re_first = r.resourceentries.where(:isFirst => true).first()
        re_first.date = r.startDate
        re_first.value = r.startValue
        re_first.save!
        respond_with(r, :location => nil)
    end

    def destroy
        r = Resource.find_resource_with_user_constraint(params[:id], current_user)
        Resourceentry.delete_all(["resource_id = ?", r.id])
        r.destroy!
        respond_with(nil)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def r_params
      params.require(:resource).permit(:name, :description, :monthlyCost, :pricePerUnit,:startDate,:annualCost, :startValue,:unit)
    end
end
