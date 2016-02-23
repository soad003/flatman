class SessionController < ApplicationController
        around_filter :wrap_in_transaction, only: [:create]

    def index
    end

    def create
        user = User.from_omniauth(request.env["omniauth.auth"])
        session[:user_id] = user.id
        user.save!
        if(user.flat.nil?)
            invite = Invite.find_by_token(session[:invite_token])
            if !invite.nil?
                user.flat=invite.flat
                user.save!
                invite.destroy!
                redirect_to root_url, :notice => t('misc.titles.logged_in')
            else
                redirect_to root_url(:anchor => "create_flat")
            end
            session[:invite_token] = nil
        else
            redirect_to root_url, :notice => t('misc.titles.logged_in')
        end
    end

    def join
        session[:invite_token]=join_params[:token]
        flash[:notice] = t('misc.titles.login_to_join')
        redirect_to signin_url, :notice => t('misc.titles.login_to_join')
    end


    def destroy
        session[:user_id] = nil
        redirect_to root_url, :notice => t('misc.titles.logged_out')
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def join_params
       params.permit(:token)
    end
end
