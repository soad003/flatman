class Api::FinanceController <Api::RestController

    def get_by_category
        @catName=Billcategory.where(:flat_id => current_user.flat_id)
        @name=Bill.includes(:billcategory).references(:billcategory).group("billcategories.name").sum(:value)
    end

    def get_overview_mates
        from = Integer(params[:from] || 0)
        to = Integer(params[:to] || 10) - from
        @overviewMates = Finance.get_overview_mates(current_user, from, to)
    end

    def get_overview_mate
    	overviewMate = Finance.get_overview_mate(current_user, User.find(params[:mate_id]))
        from = Integer(params[:from] || 0)
        to = Integer(params[:to] || overviewMate.length) - from
        overviewMate.entries=overviewMate.entries.drop(from).take(to)
        @overviewMate = overviewMate
    end
end
