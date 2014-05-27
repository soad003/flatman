class Api::SearchController < Api::RestController
  def search
    
    ownflat = current_user.flat
    items = Shareditem.which_contain(s_params[:term]).from_city(ownflat[:zip], ownflat[:city])
    c = items.map { |v| {:data => v, :distance => calc_distance(v)} }
    
    respond_with({items:c})
  end

  private
  
  
  #ins model!
  def calc_distance(item)
    ownflat = current_user.flat
    point1 = ownflat[:zip] + " " + ownflat[:city] + ", " + ownflat[:street]
    
    
    point2 = item.flat[:zip] + " " + item.flat[:city] + ", " + item.flat[:street]
    
    distance = Geocoder::Calculations.distance_between(point1, point2)
    return distance
  end

  def s_params
    params.permit(:term)
  end

end
