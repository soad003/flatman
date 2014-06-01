class Api::ShareditemController < Api::RestController
  before_action :item_params, only: [:show, :create, :update, :destroy]
  
  def get
    item=Shareditem.find(item_params[:id])
    
    if item.tags
      item = Shareditem.find(item_params[:id])
      a = item.tags.split(",")
      b = a.collect{|x| x.gsub(/\s+/, "")}
      c = b.map { |v| {:text => v} }
      item.tags = c
    end
    
    respond_with(item)
  end
  
  
  
  def removeImage
    item=Shareditem.find(item_params[:id])
    item.image = nil
    item.save
    respond_with(item)
  end
  
  def to_json(*a)
      {"text" => @items}.to_json(*a)
  end 
  
  def update
    item = Shareditem.find(item_params[:id])
    
    if !params[:imagePath]
      @up[:image] = item[:image]
      item.update!(@up)
    end

    
     #if image, manually set in directive
     if params[:imageData]
          decoded_data = Base64.decode64(params[:imageData])
          
          data = StringIO.new(decoded_data)
          data.class_eval do
            attr_accessor :content_type, :original_filename
          end
          data.content_type = params[:imageContent] 
          data.original_filename = params[:imagePath]
          @up[:image] = data
          item.update!(@up)  
      else 
         item.update!(params_no_image)  
      
      #convert json object to string
      if !params[:tags].instance_of?(String) && params[:tags]
        taggis = ""
        params[:tags].each do |tag|
         taggis = taggis + tag[:text] + ", "
        end
        item.tags = taggis[0..-3]
        item.save
      end
    end
    

    
    
    respond_with(item)
  end
 

  private
  def item_params
    @up = params.permit(:id, :image, :imageContent, :imagePath, :imageData, :description, :hidden, :sharingNote, :tags, :name, :available)
  end
  
  def params_no_image
    params.permit(:id, :description, :sharingNote, :imagePath, :tags, :name, :available, :hidden)
  end
end


 

