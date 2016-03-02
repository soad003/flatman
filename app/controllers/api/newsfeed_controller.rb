include ActionView::Helpers::DateHelper

class Api::NewsfeedController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy, :delete_checked]

    def index
        @newsfeed = generateNewsfeed(current_user)
    end

    def create
        Newsitem.createMessage(ni_params[:text], current_user)
        respond_with(nil, :location => nil)
    end

    def comment
        comment=Newsitem.new(comment_params)
        comment.flat = current_user.flat
        comment.user = current_user
        comment.save!
        comment.date = time_ago_in_words(comment.created_at)
        respond_with(comment, :location => nil)
    end

    private 
    def comment_params
      params.permit(:text, :newsitem_id)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def ni_params
      params.permit(:text)
    end

    def generateNewsfeed(user)
        newsitems = user.flat.newsitems.where(newsitem_id: nil).order(created_at: :desc)
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
    end
    
    def getImageType(ni)
        if ni[:category] == Newsitem::CATEGORIES[:message][0] then
            return "message"
        elsif [Newsitem::CATEGORIES[:payment][0], Newsitem::CATEGORIES[:bill][0]].include? ni[:category] then
            return "finance"
        elsif [Newsitem::CATEGORIES[:shoppinglistitem][0], Newsitem::CATEGORIES[:shoppinglist][0]].include? ni[:category] then
            return "shopping"
        elsif [Newsitem::CATEGORIES[:resource][0], Newsitem::CATEGORIES[:resourceitem][0]].include? ni[:category] then
            return "resource"
        end
    end

     def getLink(ni)
        if ni[:category] == Newsitem::CATEGORIES[:message][0] then
            return ni.user.image_path
        end
        ""
    end

    def getText(ni)
        if ni[:category] == Newsitem::CATEGORIES[:message][0] then
            return ni.text
        end
        return ""
    end

    def getHeader(ni)
        if Newsitem::CATEGORIES[:shoppinglist][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.shoppinglist', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        elsif Newsitem::CATEGORIES[:bill][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.bill', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        elsif Newsitem::CATEGORIES[:payment][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.payment', :name => ni.text, :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        elsif Newsitem::CATEGORIES[:shoppinglistitem][0] == ni[:category] then
            return I18n.t('activerecord.newsitem.shoppinglistitem', :items => ni.text, :list => getShoppingListName(ni.key, ni.user), :action => I18n.t('activerecord.newsitem.' + Newsitem.getActionText(ni.action)))
        end
        return ''
    end

    def getShoppingListName(key, user)
        sl = Shoppinglist.where(id: key, flat_id: user.flat.id).first
        if sl.nil? then return ""
        else return sl.name
        end
    end

end
