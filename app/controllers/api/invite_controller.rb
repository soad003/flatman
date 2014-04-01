class Api::InviteController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy]

    def create
        invite=Invite.new(invite_params)
        current_user.flat.invites << invite
        invite.save!
        #send email here
        respond_with(invite, :location => nil)
    end

    def destroy
        Invite.find_with_user_constraint(params[:id],current_user).destroy!
        respond_with(nil)
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
       params.require(:invite).permit(:email)
    end
end
