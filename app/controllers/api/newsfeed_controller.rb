class Api::NewsfeedController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy, :delete_checked]

    def index
        @newsfeed = Newsitem.generateNewsfeed(current_user)
    end

    def create
        Newsitem.createMessage(ni_params[:text], current_user)
        respond_with(nil, :location => nil)
    end

    private
        # Never trust parameters from the scary internet, only allow the white list through.
    def ni_params
      params.permit(:text)
    end

end
