class Api::SearchController < Api::RestController
  def search
    items=Shareditem.which_contain(s_params[:term])

    respond_with({items:items})
  end

  private

  def s_params
    params.permit(:term)
  end

end
