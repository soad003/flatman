class Newsitem < ActiveRecord::Base
  attr_accessor :header, :imagetype, :date, :link

  CATEGORIES = { message: 'message', comment: 'comment', useraction: 'useraction', shoppinglist: 'shoppinglist', shoppinglistitem: 'shoppinglistitem', todolist: 'todolist', todolistitem: 'todolistitem', resource: 'resourcelist', resourceitem: 'resourcelistitem', bill: 'bill', payment: 'payment' }.freeze
  ACTIONS = { add: 'add', change: 'change', remove: 'remove', done: 'done' }.freeze

  belongs_to              :user
  belongs_to              :flat
  has_many                :newsitems, -> { order 'created_at asc' }, dependent: :destroy
  belongs_to	:newsitem
  validates :user, :flat, presence: true

  def isFinance
    isPayment || isBill
  end

  def isPayment
    self[:category] == Newsitem::CATEGORIES[:payment]
  end

  def isBill
    self[:category] == Newsitem::CATEGORIES[:bill]
  end

  def isShoppingList
    self[:category] == Newsitem::CATEGORIES[:shoppinglist]
  end

  def isShoppingListItem
    self[:category] == Newsitem::CATEGORIES[:shoppinglistitem]
  end

  def isShopping
    isShoppingList || isShoppingListItem
  end

  def isTodoList
    self[:category] == Newsitem::CATEGORIES[:todolist]
  end

  def isTodoListItem
    self[:category] == Newsitem::CATEGORIES[:todolistitem]
  end

  def isTodo
    isTodoList || isTodoListItem
  end

  def isResourceList
    self[:category] == Newsitem::CATEGORIES[:resourcelist]
  end

  def isResourceListItem
    self[:category] == Newsitem::CATEGORIES[:resourcelistitem]
  end

  def isResource
    isResourceList || isResourceListItem
  end

  def isMessage
    self[:category] == Newsitem::CATEGORIES[:message]
  end

  def isComment
    self[:category] == Newsitem::CATEGORIES[:comment]
  end

  def isUseraction
    self[:category] == Newsitem::CATEGORIES[:useraction]
  end

  def self.destroy_with_user_constraint(id, user)
    msg = Newsitem.find_with_user_constraint(id, user)
    msg.destroy!
  end

  def self.find_with_user_constraint(id, user)
    find_by!(id: id, user_id: user.id, flat_id: user.flat.id)
  end

  def self.createShoppinglist(shoppinglist, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:add], shoppinglist.id, shoppinglist.name, nil)
  end

  def self.deleteShoppinglist(shoppinglist, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:remove], nil, shoppinglist.name, nil)
    Newsitem.clearShoppingListID(shoppinglist, user)
  end

  def self.ShoppingDone(shoppinglist, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglist], Newsitem::ACTIONS[:done], nil, shoppinglist.name, nil)
  end

  def self.clearShoppingListID(shoppinglist, _user)
    Newsitem.where(key: shoppinglist.id, category: Newsitem::CATEGORIES[:shoppinglistitem]).update_all(key: nil)
  end

  def self.createShoppinglistitem(shoppinglistitem, user)
    newsitem = Newsitem.getNewsitem(shoppinglistitem.shoppinglist.id, Newsitem::CATEGORIES[:shoppinglistitem], Newsitem::ACTIONS[:add], user)
    if newsitem.nil?
      Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:shoppinglistitem], Newsitem::ACTIONS[:add], shoppinglistitem.shoppinglist.id, shoppinglistitem.name, nil)
    else
      newsitem.text = (newsitem.text + ', ' + shoppinglistitem.name).strip
      newsitem.save!
    end
  end

  def self.createTodolist(todolist, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:todolist], Newsitem::ACTIONS[:add], todolist.id, todolist.name, nil)
  end

  def self.deleteTodolist(todolist, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:todolist], Newsitem::ACTIONS[:remove], nil, todolist.name, nil)
    Newsitem.clearTodoListID(todolist, user)
  end

  def self.clearTodoListID(todolist, _user)
    Newsitem.where(key: todolist.id, category: Newsitem::CATEGORIES[:todolistitem]).update_all(key: nil)
  end

  def self.createTodolistitem(todolistitem, user)
    newsitem = Newsitem.getNewsitem(todolistitem.todo.id, Newsitem::CATEGORIES[:todolistitem], Newsitem::ACTIONS[:add], user)
    if newsitem.nil?
      Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:todolistitem], Newsitem::ACTIONS[:add], todolistitem.todo.id, todolistitem.name, nil)
    else
      newsitem.text = (newsitem.text + ', ' + todolistitem.name).strip
      newsitem.save!
    end
  end

  def self.getNewsitem(key, category, action, user)
    Newsitem.find_by(key: key, category: category, user: user, flat: user.flat, action: action, updated_at: (DateTime.current - 10.minutes)..DateTime.current)
  end

  def self.createMessage(text, user)
    newsitem = Newsitem.where(category: Newsitem::CATEGORIES[:message], flat: user.flat, action: Newsitem::ACTIONS[:add], updated_at: (DateTime.current - 20.seconds)..DateTime.current).order(updated_at: :desc).first
    if !newsitem.nil? && newsitem.user.id == user.id && newsitem.newsitem_id.nil?
      newsitem.text = (newsitem.text + "\n" + text).strip
      newsitem.save!
    else
      Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:message], Newsitem::ACTIONS[:add], nil, text, nil)
    end
  end

  def self.createComment(text, newsitem_id, user)
    comment = Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:comment], Newsitem::ACTIONS[:add], nil, text, newsitem_id)
    comment.date = time_ago_in_words(comment.created_at)
    comment
  end

  def self.createBill(bill, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:bill], Newsitem::ACTIONS[:add], bill.id, bill.text, nil)
  end

  def self.updateBill(bill, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:bill], Newsitem::ACTIONS[:change], bill.id, bill.text, nil)
  end

  def self.deleteBill(bill, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:bill], Newsitem::ACTIONS[:remove], nil, bill.text, nil)
  end

  def self.createPayment(payment, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:payment], Newsitem::ACTIONS[:add], payment.id, payment.payer.name, nil)
  end

  def self.deletePayment(payment, user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:payment], Newsitem::ACTIONS[:remove], nil, payment.payer.name, nil)
  end

  def self.deleteUser(user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:useraction], Newsitem::ACTIONS[:remove], nil, nil, nil)
  end

  def self.addUser(user)
    Newsitem.saveNewsitem(user, Newsitem::CATEGORIES[:useraction], Newsitem::ACTIONS[:add], nil, nil, nil)
  end

  def self.saveNewsitem(user, category, action, key, text, newsitem_id)
    ni = Newsitem.new
    ni.user = user
    ni.flat = user.flat
    ni.category = category
    ni.action = action
    ni.key = key unless key.nil?
    ni.text = text unless text.nil?
    ni.newsitem_id = newsitem_id unless newsitem_id.nil?
    Newsitem.push(ni)
    ni.save!
    ni
  end

  def self.getPushMessage(newsitem, locale)
    I18n.locale = locale
    if newsitem.isShopping && newsitem.action == Newsitem::ACTIONS[:done]
                           then return I18n.t('activerecord.newsitem.pushShoppingDone', name: newsitem.user.name) end
    if newsitem.isFinance then return I18n.t('activerecord.newsitem.pushFinance', name: newsitem.user.name) end
    if newsitem.isShopping then return I18n.t('activerecord.newsitem.pushShopping', name: newsitem.user.name) end
    if newsitem.isTodo then return I18n.t('activerecord.newsitem.pushTodo', name: newsitem.user.name) end
    if newsitem.isResource then return I18n.t('activerecord.newsitem.pushResource', name: newsitem.user.name) end
    if newsitem.isMessage then return I18n.t('activerecord.newsitem.pushMessage', name: newsitem.user.name) end
    if newsitem.isComment then return I18n.t('activerecord.newsitem.pushComment', name: newsitem.user.name) end
    if newsitem.isUseraction then return I18n.t('activerecord.newsitem.pushMatechange_' + newsitem.action, name: newsitem.user.name) end
  end

  def self.push(newsitem)
    # pushlogic
    # puts (newsitem)
    # puts ("-----------------------------> " + Newsitem.sendPush(newsitem).to_s + " <-------------------------")
    if Newsitem.sendPush(newsitem)
      newsitem.user.flat.users.each do |mate|
        message = Newsitem.getPushMessage(newsitem, mate.locale)
        next unless mate.id != newsitem.user.id && mate.pushflag && !(mate.device_token == '' || mate.device_token.nil?)
        device_token = mate.device_token
        platform = mate.platform
        Thread.new do
          if platform == 'android'
            push = PushBot::Push.new(device_token, :android)
            push.notify(message)
          else
            push = PushBot::Push.new(device_token, :ios)
            push.notify(message)
            end
        end
      end
    end
  end

  def self.sendPush(newsitem)
    if newsitem.isShopping && newsitem.action == Newsitem::ACTIONS[:done] # shopping done
      lastnewsitem = Newsitem.getNewsitemForPush(newsitem.flat, [Newsitem::CATEGORIES[:shoppinglist]], [Newsitem::ACTIONS[:done]])
    elsif newsitem.isShopping && (newsitem.action != Newsitem::ACTIONS[:done]) # last shopping push
      lastnewsitem = Newsitem.getNewsitemForPush(newsitem.flat, [Newsitem::CATEGORIES[:shoppinglist], Newsitem::CATEGORIES[:shoppinglistitem]], nil)
    elsif newsitem.isTodo # last todo push
      lastnewsitem = Newsitem.getNewsitemForPush(newsitem.flat, [Newsitem::CATEGORIES[:todolist], Newsitem::CATEGORIES[:todolistitem]], nil)
    elsif newsitem.isFinance # last todo push
      lastnewsitem = Newsitem.getNewsitemForPush(newsitem.flat, [Newsitem::CATEGORIES[:bill], Newsitem::CATEGORIES[:payment]], nil)
    elsif newsitem.isComment # last todo push
      lastnewsitem = Newsitem.getNewsitemForPush(newsitem.flat, [Newsitem::CATEGORIES[:comment]], nil)
    end

    return false if !lastnewsitem.nil? && lastnewsitem.user == newsitem.user
    true
  end

  def self.getNewsitemForPush(flat, categories, actions)
    if actions.nil?
      return Newsitem.where(category: categories, flat: flat, updated_at: (DateTime.current - 2.minutes)..DateTime.current).order(updated_at: :desc).first
    else
      return Newsitem.where(category: categories, action: actions, flat: flat, updated_at: (DateTime.current - 2.minutes)..DateTime.current).order(updated_at: :desc).first
    end
  end
end
