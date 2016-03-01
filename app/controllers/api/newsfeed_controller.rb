class Api::NewsfeedController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy, :delete_checked]

    def index
        @newsfeed=current_user.flat.newsitems.order(created_at: :desc)
    end

    def create
        flat=current_user.flat
        newsitem = Newsitem.new(ni_params)
        newsitem.user = current_user
        newsitem.newsitemcategory = Newsitemcategory.getMessageCategory()
        flat.newsitems << newsitem
        flat.save!
        respond_with(nil, :location => nil)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def ni_params
      params.permit(:text)
    end

end
