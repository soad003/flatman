class Api::ShoppinglistController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy, :delete_checked]

    def index
        @sl=current_user.flat.shoppinglists.select {|x| x.user == nil || x.user == current_user }
    end

    def create
        flat=current_user.flat
        @sl=Shoppinglist.new(sl_params)
        @sl.user = current_user if params[:privat]
        flat.shoppinglists << @sl
        flat.save!
        Newsitem.createShoppinglist(@sl, current_user)
    end

    def destroy
        sl = Shoppinglist.find_list_with_user_constraint(params[:id], current_user)
        Newsitem.deleteShoppinglist(sl, current_user)
        sl.destroy!
        respond_with(nil)
    end

    def delete_checked
        sl = Shoppinglist.find_list_with_user_constraint(params[:shoppinglist_id], current_user)
        sl.shoppinglistitems.select {|x| x.checked}.each {|x| x.destroy!}
        respond_with(nil)
    end


    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def sl_params
      params.permit(:name)
    end

end
