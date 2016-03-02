class Api::ShoppingitemController < Api::RestController

    def create
        item=Shoppinglistitem.new(item_params)
        item.user=current_user
        sl = Shoppinglist.find_list_with_user_constraint(params[:shoppinglist_id], current_user)
        sl.shoppinglistitems << item
        sl.save!
        Newsitem.createShoppinglistitem(item, current_user)
        respond_with(item, :location => nil)
    end

    def destroy
        Shoppinglistitem.destroy_with_user_constraint(params[:id],params[:shoppinglist_id],current_user)
        respond_with(nil)
    end

    def update
        item = Shoppinglistitem.find_with_user_constraint(params[:id],params[:shoppinglist_id],current_user)
        item.update_attributes!(item_params)
        respond_with(nil, :location => nil)
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.permit(:name,:checked,:shoppinglist_id,:id)
    end

end
