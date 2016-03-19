class Api::UserController < Api::RestController
  def index
    @user = current_user
  end

  def update
    current_user.pushflag = update_params[:pushflag]
    current_user.save!
    respond_with(nil, location: nil)
  end

  private

  def update_params
    params.permit(:pushflag)
  end
end
