class TemplatesController < ProtectedController
 layout false, except: [:index]
 before_action :check_if_flat, except: [:index,:create_flat]

  def index
  end

  def dashboard
  end

  def finances
  end

  def finance_entry
  end

  def finance_overview_mate
  end

  def bills_overview
  end

  def resources
  end

  def create_resource
  end

  def create_payment
  end

  def shopping
  end

  def user_settings
  end

  def flat_settings
  end

  def create_flat
  end

  private
  def check_if_flat
    #special case user not in flat see config.js
    render json: nil, status: 409 unless current_user.has_flat?
  end

end
