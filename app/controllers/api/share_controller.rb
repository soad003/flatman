class Api::ShareController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create,:destroy]
  
  def index
    @si=current_user.flat.shareditems
  #  respond_with("lulu")
    respond_with(current_user.flat.shareditems)
  end

  def create
    flat = current_user.flat
    newitem = Shareditem.new(si_params)
    flat.shareditems << newitem
    flat.save!
    respond_with(newitem, :location => nil)
  end
  
  def destroy
    item = Shareditem.find(si_params[:id])
    item.destroy!
    respond_with(nil)
  end
  

  private
  def si_params
    params.permit(:id, :name, :description, :tags, :sharingNote)
  end

end
