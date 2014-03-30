class Api::ShareditemController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create,:destroy]
  
  def index
    @si=current_user
 #  respond_with("lulu")
    respond_with(current_user)
  end
  

  private
  def si_params
    params.permit(:name, :description, :tags, :sharingNote)
  end

end
