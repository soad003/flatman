class Api::TodoController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy, :delete_checked]

    def index
        @sl=current_user.flat.todos.select {|x| x.user == nil || x.owned_by?(current_user) }
    end

    def create
        flat=current_user.flat
        @todo=Todo.new(sl_params)
        @todo.user = current_user if params[:privat]
        flat.todos << @todo
        flat.save!
        Newsitem.createTodolist(@todo, current_user) if !@todo.is_private?
    end

    def destroy
        sl = Todo.find_list_with_user_constraint(params[:id], current_user)
        Newsitem.deleteTodolist(sl, current_user) if !sl.is_private?
        sl.destroy!
        respond_with(nil)
    end

    def delete_checked
        sl = Todo.find_list_with_user_constraint(params[:todo_id], current_user)
        sl.todo_items.select {|x| x.checked}.each {|x| x.destroy!}
        respond_with(nil)
    end


    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def sl_params
      params.permit(:name)
    end

end
