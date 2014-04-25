class Api::UploadController < ApplicationController
  protect_from_forgery :except => :create 
  
  # GET /uploads
  def index
    @uploads = Upload.all
  end

  # GET /uploads/new
  def new
    @uploads = Upload.new
  end

  # POST /users
  def create
    @upload = Upload.new(u_params)
    @upload.save
    redirect_to :back
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def u_params
    params.require(:upload).permit(:file, :item)
  end
end
