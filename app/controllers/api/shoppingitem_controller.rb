class Api::ShoppingitemController < Api::RestController

    def create
        item=Shoppinglistitem.new(item_params)
        sl = Shoppinglist.find_list_with_user(params[:shoppinglist_id], current_user)
        sl.shoppinglistitems << item
        sl.save!
        respond_with(item, :location => nil)
    end

    def destroy
        Shoppinglistitem.destroy_with_user(params[:shoppinglist_id],params[:id], current_user)
        respond_with(nil)
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.require(:shoppingitem).permit(:name)
    end

end
