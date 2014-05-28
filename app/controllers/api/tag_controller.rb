class Api::TagController < Api::RestController
  
  def find
    tags = Shareditem.uniq.pluck(:tags).join(", ").split(", ").select{ |i| i[/^#{s_params[:term]}/] }
    c = tags.map { |v| {:text => v} }
    respond_with({tags:c})
  end
  
  private
    def s_params
      params.permit(:term)
    end

end