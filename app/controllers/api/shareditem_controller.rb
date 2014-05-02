class Api::ShareditemController < Api::RestController
  before_action :item_params, only: [:show, :create, :update, :destroy]
  
  def updload
    puts "leck mi"
    decoded_data = Base64.decode64(item_params[:imageData]) # json parameter set in directive scope
    # create 'file' understandable by Paperclip
   
    
    data = StringIO.new(decoded_data)
    data.class_eval do
      attr_accessor :content_type, :original_filename
    end

    # set file properties
    data.content_type = item_params[:imageContent] # json parameter set in directive scope
    data.original_filename = item_params[:imagePath] # json parameter set in directive scope

    # update hash, I had to set @up to persist the hash so I can pass it for saving
    # since set_params returns a new hash everytime it is called (and must be used to explicitly list which params are allowed otherwise it throws an exception)
    @up[:image] = data # user Icon is the model attribute that i defined as an attachment using paperclip generator
    
    
    item = Shareditem.find(item_params[:id])
    item.image = data
    item.contentType = item_params[:imageContent]
    item.update(@up)  
    render json: item
    
    
  end
  
  def get
    item=Shareditem.find(item_params[:id])
    if item 
      respond_with(item)
    else
       respond_with_errors([t('.no_item_found')])
       #warum andre errormessage?
    end
  end
  
  def update
     item = Shareditem.find(item_params[:id])
     item.update_attributes!(item_params)
     respond_with("nil", :location => nil);
  end
 # r = Ressource.find_resource_with_user_constraint(params[:id], current_user)
   

  private
  def item_params
    #requrie funzt nit, weil /id.
    @up = params.permit(:id, :image, :imageContent, :imagePath, :imageData, :description, :sharingNote, :tags, :name, :available)
  end
  
end


 

