class Api::ShareditemController < Api::RestController
  
  
  
  def get
    item=Shareditem.find(s_params[:id])
    if item 
      respond_with(item)
    else
       respond_with_errors([t('.no_item_found')])
       #warum kimb do a sa gschissena drecks errormessage.?
    end
  end
  
  def update
     item = Shareditem.find(params[:id])
     item.update_attributes!(s_params)
     respond_with(nil, :location => nil);
  end
 # r = Ressource.find_resource_with_user_constraint(params[:id], current_user)
   

  private
  def s_params
    #warum geht de scheiße nit mit require?
   params.permit(:id, :shareditem, :name, :tags, :available, :hidden, :description, :sharingNote, :image_path, :flat_id, :created_at, :updated_at)
  end

end


 

