class Api::TagController < Api::RestController

  def find
    #voodoo. first tagke all tags from shared items (unique), 
    #join them to string (in one item could be more tags which start with same letter), 
    #split them to an array, select those which start with given term
    tags = Shareditem.uniq.pluck(:tags).join(", ").split(", ").select{ |i| i[/^#{s_params[:term]}/] }
    respond_with({tags:tags})
  end

  private

  def s_params
    params.permit(:term)
  end

end
#