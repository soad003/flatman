class Api::FinanceController <Api::RestController
	around_filter :wrap_in_transaction, only: [:create, :update]

	def index
		@finEntries=Bill.calc(current_user.user.bills)
    end

    def create

    end

    def update

    end

    def destroy


    end
end