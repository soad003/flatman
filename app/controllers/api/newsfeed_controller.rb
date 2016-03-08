include ActionView::Helpers::DateHelper

class Api::NewsfeedController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create, :destroy]

    def index
        @feed = generateNewsfeed(current_user)
    end

    def create
        Newsitem.createMessage(ni_params[:text], current_user)
        respond_with(nil, :location => nil)
    end

    def destroy
        Newsitem.destroy_with_user_constraint(ni_params[:id], current_user)
        respond_with(nil)
    end

    def comment
        comment = Newsitem.createComment(comment_params[:text], comment_params[:newsitem_id], current_user)
        respond_with(comment, :location => nil)
    end

    private
    def comment_params
      params.permit(:text, :newsitem_id, :from, :to)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def ni_params
      params.permit(:text, :from, :to, :id)
    end

    def generateNewsfeed(user)
        feed = OpenStruct.new({"length" => 0, "data" => []})

        from = Integer(ni_params[:from] || 0)
        to = Integer(ni_params[:to] || 10)  - from
        newsitems = user.flat.newsitems.where(newsitem_id: nil).order(created_at: :desc)
        feed.length = newsitems.length()
        newsitems = newsitems.drop(from).take(to)
        newsitems.each do |newsitem|
            newsitem.header = getHeader(newsitem)
            newsitem.text = getText(newsitem)
            newsitem.imagetype = getImageType(newsitem)
            newsitem.link = getLink(newsitem)
            newsitem.date = time_ago_in_words(newsitem.created_at)
            newsitem.newsitems.each do |comment|
                comment.date = time_ago_in_words(comment.created_at)
            end
        end
        feed.data = newsitems
        feed
    end
    
    def getImageType(ni)
        if ni.isMessage() then
            return "message"
        elsif ni.isFinance() then
            return "finance"
        elsif ni.isShopping() then
            return "shopping"
        elsif ni.isResource() then
            return "resource"
        elsif ni.isUseraction() then
            return "useraction"
        elsif ni.isTodo() then
            return "todo"
        end
    end

     def getLink(ni)
        if ni.isMessage() then
            return ni.user.image_path
        end
        ""
    end

    def getText(ni)
        if ni.isMessage() then
            return ni.text
        end
        return ""
    end

    def getHeader(ni)
        if ni.isShoppingList() then
            return I18n.t('activerecord.newsitem.shoppinglist', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif ni.isShoppingListItem() then
            return I18n.t('activerecord.newsitem.shoppinglistitem', :items => ni.text, :list => getShoppingListName(ni.key, ni.user), :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif ni.isBill() then
            return I18n.t('activerecord.newsitem.bill', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif ni.isPayment() then
            return I18n.t('activerecord.newsitem.payment', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif ni.isTodoList() then
            return I18n.t('activerecord.newsitem.todolist', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif ni.isTodoListItem() then
            return I18n.t('activerecord.newsitem.todolistitem', :items => ni.text, :list => getTodoName(ni.key, ni.user), :action => I18n.t('activerecord.newsitem.' + ni.action))
        elsif ni.isUseraction() then
            return I18n.t('activerecord.newsitem.matechange_' + ni.action)
        end
        return ''
    end

    def getShoppingListName(key, user)
        sl = Shoppinglist.where(id: key, flat_id: user.flat.id).first
        if sl.nil? then return ""
        else return sl.name
        end
    end

    def getTodoName(key, user)
        todo = Todo.where(id: key, flat_id: user.flat.id).first
        if todo.nil? then return ""
        else return todo.name
        end
    end

end
