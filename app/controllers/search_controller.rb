class SearchController < ProtectedController

  def show
    @search=params[:term]
  end

end
