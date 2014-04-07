class Api::FinanceController <Api::RestController
	around_filter :wrap_in_transaction, only: [:create, :update]

	def index
		@finEntries=Bill.calc(current_user.user.bills)
        #@r=Ressource.calc(current_user.flat.ressources);
        #logic model calc call

        #respond_with(current_user.flat.ressources)
    end

    def create

    end

    def update

    end

    def destroy


    end
end