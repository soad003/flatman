class Api::TodoItemController < Api::RestController

    def create
        item=TodoItem.new(item_params)
        item.user=current_user
        sl = Todo.find_list_with_user_constraint(params[:todo_id], current_user)
        sl.todo_items << item
        sl.save!
        #Newsitem.createShoppinglistitem(item, current_user)
        respond_with(item, :location => nil)
    end

    def destroy
        TodoItem.destroy_with_user_constraint(params[:id],params[:todo_id],current_user)
        respond_with(nil)
    end

    def update
        item = TodoItem.find_with_user_constraint(params[:id],params[:todo_id],current_user)
        item.update_attributes!(item_params)
        respond_with(nil, :location => nil)
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params.permit(:name,:checked,:todo_id,:id)
    end

end
