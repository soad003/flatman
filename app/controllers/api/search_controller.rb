class Api::SearchController < Api::RestController
   def search
    items = Shareditem.which_contain(s_params[:term]).joins(:flat)
    c = items.map { |v| {
        :data => v,
        :distance => current_user.flat.get_distance_to(v.flat).round(2),
        :flatname => v.flat.name,
        :flat_id => v.flat_id
        }
    }
    c = c.sort {|x,y| (x[:distance] <=> y[:distance])}
    respond_with({items:c})
  end

  private
  def s_params
    params.permit(:term)
  end

end
