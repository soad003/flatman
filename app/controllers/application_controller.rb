class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

    def wrap_in_transaction
        ActiveRecord::Base.transaction do
            begin
                yield
            end
        end
    end

    def default_url_options(options={})
        { locale: I18n.locale }
    end

    private

    def set_locale
        if params[:locale].nil? || params[:locale].empty?
            I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
        else
            I18n.locale = params[:locale]
        end
        I18n.locale = I18n.locale || I18n.default_locale
    end

end
