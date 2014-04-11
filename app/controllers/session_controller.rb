class SessionController < ApplicationController
        around_filter :wrap_in_transaction, only: [:create]

    def index
    end

    def create
        user = User.from_omniauth(request.env["omniauth.auth"])
        session[:user_id] = user.id
        user.save!
        if(user.flat.nil?)
            invite = Invite.find_by_email(user.email)
            if !invite.nil?
                user.flat=invite.flat
                user.save!
                invite.destroy!
                redirect_to root_url, :notice => t('misc.titles.logged_in')
            else
                redirect_to root_url(:anchor => "create_flat")
            end
        else
            redirect_to root_url, :notice => t('misc.titles.logged_in')
        end
    end

    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => t('misc.titles.logged_out')
    end
end
