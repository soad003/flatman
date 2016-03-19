class Todo < ActiveRecord::Base
  belongs_to	:flat
  belongs_to :user
  has_many	:todo_items, -> { order 'created_at asc' }, dependent: :destroy
  validates :name, :flat, presence: true

  def is_private?
    !user.nil?
  end

  def owned_by?(me)
    is_private? && user == me
  end

  def self.find_list_with_user_constraint(id, user)
    find_by!(id: id, flat_id: user.flat.id)
  end
end
