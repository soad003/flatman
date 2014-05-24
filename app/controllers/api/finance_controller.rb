class Api::FinanceController <Api::RestController

    def get_by_category
        @catName=Billcategory.where(:flat_id => current_user.flat_id)
        @name=Bill.includes(:billcategory).references(:billcategory).group("billcategories.name").sum(:value)
    end

    def get_finance_tables
      @userTables = Finance.getUserTables(current_user)
    end
end
