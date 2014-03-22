class Templates::TemplatesController < ProtectedController
 layout false, except: [:index]

  def self.controller_path
    "templates"
  end

  def index
  end

  def dashboard
  end

  def share
  end

  def finances
  end

  def resources
  end

  def messages
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

end
