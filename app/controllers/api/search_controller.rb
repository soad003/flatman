class Api::SearchController < Api::RestController
  def search
    
    ownflat = current_user.flat
    items = Shareditem.which_contain(s_params[:term]).where(ownflat[:city])
    respond_with({items:items})
  end

  private

  def s_params
    params.permit(:term)
  end

end
