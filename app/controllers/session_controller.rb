class SessionController < ApplicationController

    def index
    end

    def create
        user = User.from_omniauth(request.env["omniauth.auth"])
        session[:user_id] = user.id
        redirect_to dashboard_url, :notice => t('misc.titles.logged_in')
    end

    def destroy
        session[:user_id] = nil
        redirect_to dashboard_url, :notice => t('misc.titles.logged_out')
    end
end
