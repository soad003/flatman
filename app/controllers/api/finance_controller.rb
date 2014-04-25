class Api::FinanceController <Api::RestController
	around_filter :wrap_in_transaction, only: [:create, :update]

	def index
		@f=Bill.all
        respond_with(@f)
        #@f=Bill.calc(current_user.user.bills)
    end

    def create
        u = current_user
        b=Bill.new(f_params)
        u.bills << b
        u.save!
    end

    def update

    end

    def destroy
        #f = Bill.find_by(params[:id]));
        f = Bill.find_financial_with_user_constraint(params[:id], current_user)
        f.destroy!
        respond_with(nil)
    end

    private
    def f_params
        params.permit(:value, :date, :user_id, :billcategory_id)
    end

end