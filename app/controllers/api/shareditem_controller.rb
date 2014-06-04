class Api::ShareditemController < Api::RestController
 

  def get
    item=Shareditem.find(params[:id])

    if item.tags
      item = Shareditem.find(params[:id])
      a = item.tags.split(",")
      b = a.collect{|x| x.gsub(/\s+/, "")}
      c = b.map { |v| {:text => v} }
      item.tags = c
    end

    respond_with(item)
  end

  def removeImage
    item=Shareditem.find(params[:id])
    item.image = nil
    item.save
    respond_with(item)
  end

  def to_json(*a)
      {"text" => @items}.to_json(*a)
  end

  def update
    item = Shareditem.find(params[:id])

    #if image, manually set in directive
    if params[:imageData]
        decoded_data = Base64.decode64(params[:imageData])

        data = StringIO.new(decoded_data)
        data.class_eval do
          attr_accessor :content_type, :original_filename
        end
        data.content_type = params[:imageContent]
        data.original_filename = params[:imagePath]
        item.update!({image: data})
    else
        if(!params[:tags].is_a? String)
          item.tags=params[:tags].map {|a| a[:text]}.join(", ")
        end
        item.update!(params_no_image)
    end

    respond_with(item)
  end

  private

  def params_no_image
    params.permit(:id, :description, :sharingNote, :tags, :name, :available, :hidden)
  end
  
end