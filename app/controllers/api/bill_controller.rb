class Api::BillController <Api::RestController
    around_filter :wrap_in_transaction, only: [:create, :update, :destroy]

    def index
        bills_of_all_users=current_user.flat.bills.sort {|x,y| -(x.date <=> y.date)}
        from = Integer(params[:from] || 0)
        to = Integer(params[:to] || bills_of_all_users.length) -from

        @bills=OpenStruct.new({"totalLength" => bills_of_all_users.length, "subset" => bills_of_all_users.drop(from).take(to)})
    end

    def show
        @bill=Bill.find(params[:id])
    end

     def create
        cat = Billcategory.new_or_existing(create_params[:cat_name], current_user.flat)
        @bill= Bill.new_with_params(create_params,cat, current_user.flat)
        @bill.save!
        Newsitem.createBill(@bill, current_user)
        respond_with(nil)
    end

    def update
        f = Bill.find_bill_with_user_constraint(params[:id])
        if(f.is_editable?)
            f.update_attributes!(bill_params)
            cat = Billcategory.new_or_existing(params[:cat_name], current_user.flat)
            f.billcategory = cat
            f.save!
            Newsitem.updateBill(f, current_user)
            respond_with(nil)
        else
            respond_with_errors([t('.no_edit_deleted_users')])
        end  
    end

    def destroy
        f = Bill.find_bill_with_user_constraint(params[:id])
        if(f.is_editable?)
            Newsitem.deleteBill(f, current_user)
            Bill.destroy_with_user_constraint(params[:id], current_user)
            respond_with(nil)
        else
            respond_with_errors([t('.no_edit_deleted_users')])
        end
    end

    private
    def create_params
      params[:user_ids] ||= []
      params.permit(:text, :value,:user_id, :date, :cat_name, user_ids: [])
    end

    private
    def bill_params
      params[:user_ids] ||= []
      params.permit(:text, :value,:user_id, :date, user_ids: [])
    end
end
