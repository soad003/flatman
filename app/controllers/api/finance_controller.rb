class Api::FinanceController <Api::RestController

    def get_by_category
        @catName=Billcategory.where(:flat_id => current_user.flat_id)
        @name=Bill.includes(:billcategory).references(:billcategory).group("billcategories.name").sum(:value)
    end

    def get_finance_tables
      @userTables = Finance.get_user_tables(current_user)
    end

    def get_finance_table
    	@userTable = Finance.get_user_table(current_user, User.find(params[:member_id]), params[:page] )
    end
end
