class ProtectedController < ApplicationController

    before_action :check_if_loggedin

    def check_if_loggedin
        redirect_to signin_url if !logged_in
    end
end
