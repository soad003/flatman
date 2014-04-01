class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :current_user
  helper_method :logged_in
  helper_method :is_user_ready_to_go


    def wrap_in_transaction
        ActiveRecord::Base.transaction do
            begin
                yield
            end
        end
    end

    def current_user
         @current_user ||= User.find_by_id(session[:user_id]) if session[:user_id]
    end

    def logged_in
        !current_user.nil?
    end

    def is_user_ready_to_go
      logged_in && !current_user.flat.nil?
    end

    private

    def set_locale

        if (params[:locale].nil? || params[:locale].empty?) && (cookies[:locale].nil? || cookies[:locale].empty?)
            I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
        elsif !(params[:locale].nil? || params[:locale].empty?)
            I18n.locale = params[:locale]
        elsif !(cookies[:locale].nil? || cookies[:locale].empty?)
            I18n.locale = cookies[:locale]
        end

        I18n.locale = I18n.locale || I18n.default_locale
        cookies[:locale]=I18n.locale
    end



end
