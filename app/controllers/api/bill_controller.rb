class Api::BillController <Api::RestController
    around_filter :wrap_in_transaction, only: [:create, :update]
    def show
        @bill=Bill.find(params[:id])
    end

     def create
        cat = Billcategory.new_or_existing(create_params[:cat_name], current_user.flat)
        @bill= Bill.new_with_params(create_params,cat, current_user.flat)
        @bill.save!
        respond_with(nil)
    end

    def update

    end

    def destroy
       Bill.destroy_with_user_constraint(params[:id], current_user)
       respond_with(nil)
    end

    private
    def create_params
      params[:user_ids] ||= []
      params.permit(:text, :value,:user_id, :date, :cat_name, user_ids: [])
    end
end
