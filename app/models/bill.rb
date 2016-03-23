class Bill < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to              :billcategory
  belongs_to              :user
  belongs_to              :flat

  validates               :date, :text, :user, presence: true
  validates               :value, numericality: { greater_than: 0 }, presence: true
  validates               :users, length: { minimum: 1 }
  validates_associated    :billcategory, message: nil

  def is_editable?
    users.all? { |u| flat.id == u.flat_id } && user.flat_id == flat.id
  end

  def self.destroy_with_user_constraint(id, user)
    b = Bill.joins(:user)
            .select('bills.*')
            .where('bills.id=? and users.flat_id=?', id, user.flat_id)
            .first
    b.billcategory.destroy! if b.billcategory.bills.count == 1
    b.destroy!
  end

  def self.find_bill_with_user_constraint(id)
    Bill.where(id: id).first
  end

  def self.new_with_params(p, cat, flat)
    Bill.new.tap do |b|
      b.text = p[:text]
      b.date = p[:date]
      b.value = p[:value]
      b.user_id = p[:user_id]
      b.billcategory = cat
      b.flat_id = flat.id
      b.users = p[:user_ids].map { |id| User.find_with_flat_constraint(id, flat) }
    end
  end

  def self.get_payees(bills, user)
    returnList = []
    bills.each do |b|
      returnList << b if b.user_id == user.id
    end
    returnList
  end

  def self.get_categories_and_sum(categoryFlat, billsFlat)
    catsum = {}
    categoryFlat.each do |c|
      tmp = 0
      billsFlat.each do |b|
        tmp += b.value if c.id == b.billcategory_id
        catsum[c.name] = tmp
      end
    end
    catsum
  end
end
