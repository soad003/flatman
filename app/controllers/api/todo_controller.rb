class Api::TodoController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy, :delete_checked]

    def index
        puts current_user.flat.todos.to_json
        @sl=current_user.flat.todos
    end

    def create
        flat=current_user.flat
        sl=Todo.new(sl_params)
        flat.todos << sl
        flat.save!
        Newsitem.createTodolist(sl, current_user)
        respond_with(sl, :location => nil)
    end

    def destroy
        sl = Todo.find_list_with_user_constraint(params[:id], current_user)
        Newsitem.deleteTodolist(sl, current_user)
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
