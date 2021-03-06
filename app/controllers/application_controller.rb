class ApplicationController < ActionController::Base
  before_action :handle_device_token
  before_action :handle_platform
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale

  helper_method :current_user
  helper_method :logged_in
  helper_method :is_user_ready_to_go
  helper_method :is_app_user?
  helper_method :logout

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

  def is_app_user?
    !cookies[:platform].blank?
  end

  def logout
    session[:user_id] = nil
    @current_user.logout(is_app_user?)
    @current_user = nil
  end

  private

  def handle_device_token
    token = cookies[:device_token]
    current_user.set_device(token) if !token.blank? && logged_in
  end

  def handle_platform
    platform = cookies[:platform]
    if logged_in && !platform.blank?
      if platform.to_s == 'android'
        current_user.set_platform('android')
      elsif platform.to_s == 'ios'
        current_user.set_platform('ios')
      end
    end
  end

  def set_locale
    if (params[:locale].nil? || params[:locale].empty?) &&
       (cookies[:locale].nil? || cookies[:locale].empty?)
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    elsif !(params[:locale].nil? || params[:locale].empty?)
      I18n.locale = params[:locale]
    elsif !(cookies[:locale].nil? || cookies[:locale].empty?)
      I18n.locale = cookies[:locale]
    end
    I18n.locale = I18n.locale || I18n.default_locale
    cookies[:locale] = I18n.locale
    if logged_in && current_user.locale != I18n.locale.to_s
      current_user.locale = I18n.locale
      current_user.save!
    end
  end
end
