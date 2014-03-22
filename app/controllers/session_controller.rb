class SessionController < ApplicationController

    def index
    end

    def create
        user = User.from_omniauth(request.env["omniauth.auth"])
        session[:user_id] = user.id
        if(user.flat.nil?)
            redirect_to root_url(:anchor => "create_flat")
        else
         redirect_to root_url, :notice => t('misc.titles.logged_in')
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => t('misc.titles.logged_out')
    end
end
