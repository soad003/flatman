class TemplatesController < ProtectedController
 layout false, except: [:index]
 before_action :check_if_flat, except: [:index,:create_flat]

  def index
  end

  def dashboard
  end

  def share
  end

  def finances
  end

  def finances_new
  end

  def finances_overview
  end

  def resources
  end

  def messages
  end

  def create_message
  end

  def shopping
  end

  def user_settings
  end

  def flat_settings
  end

  def create_flat
  end

  def search
  end

  def check_if_flat
    #special case user not in flat see config.js
    render json: nil, status: 409 unless current_user.has_flat?
  end

end
