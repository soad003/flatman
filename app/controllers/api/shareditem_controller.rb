class Api::ShareditemController < Api::RestController
  before_action :item_params, only: [:show, :create, :update, :destroy]
  
  def get
    item=Shareditem.find(item_params[:id])
    if item 
      respond_with(item)
    else
       respond_with_errors([t('.no_item_found')])
       #warum andre errormessage?
    end
  end
  
  def removeImage
    item=Shareditem.find(item_params[:id])
    item.image = nil
    item.save
    respond_with(item)
  end
  
  def update
    item = Shareditem.find(item_params[:id])
    
     if params[:imageData]
          logger.debug "he du pferd"
          decoded_data = Base64.decode64(params[:imageData])
          
          data = StringIO.new(decoded_data)
          data.class_eval do
            attr_accessor :content_type, :original_filename
          end
          data.content_type = params[:imageContent] # json parameter set in directive scope
          data.original_filename = params[:imagePath] # json parameter set in directive scope
          @up[:image] = data
    end

    
    item.update!(@up)  
    respond_with(item)
  end
 # r = Ressource.find_resource_with_user_constraint(params[:id], current_user)
   

  private
  def item_params
    #requrie funzt nit, weil /id.
    @up = params.permit(:id, :image, :imageContent, :imagePath, :imageData, :description, :sharingNote, :tags, :name, :available)
  end
  
end


 

