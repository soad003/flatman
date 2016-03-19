class TodoItem < ActiveRecord::Base
  belongs_to	:user
  belongs_to	:todo
  validates   :name, :todo, :user, presence: true
  validates   :checked, inclusion: { in: [true, false] }

  def self.destroy_with_user_constraint(id, sl_id, user)
    item = TodoItem.find_with_user_constraint(id, sl_id, user)
    item.destroy!
  end

  def self.find_with_user_constraint(id, sl_id, user)
    sl = Todo.find_list_with_user_constraint(sl_id, user)
    sl.todo_items.find { |i| i.id == id.to_i } unless sl.nil?
  end
end
