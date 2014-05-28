class Api::SearchController < Api::RestController
  
  def search
    items = Shareditem.which_contain(s_params[:term]).from_city(current_user.flat[:zip], current_user.flat[:city])
    c = items.map { |v| {:data => v, :distance => calc_distance(v).round(2)} }
    respond_with({items:c})
  end

  private
  
  def calc_distance(item)
    return current_user.flat.get_distance_to(item.flat)
  end

  def s_params
    params.permit(:term)
  end

end
