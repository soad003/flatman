class Api::InviteController < Api::RestController
    around_filter :wrap_in_transaction, only: [:create,:destroy]

    def create
        user = User.find_by_email(invite_params[:email])
        if user.nil?
            invite=Invite.new(invite_params)
            current_user.flat.invites << invite
            invite.save!
            UserMailer.invite(invite.email,current_user.flat.name, invite.token).deliver
            @return = OpenStruct.new({already_registred: false, invite: invite})
        else
            if current_user.flat.is_member?(user)
                respond_with_errors([t('.already_member_flat')])
            elsif user.has_flat?
                respond_with_errors([t('.already_in_flat')])
            else
                current_user.flat.add_user(user)
                UserMailer.added_to_flat(user).deliver
                @return = OpenStruct.new({already_registred: true, user: user})
            end
        end
    end

    def destroy
        Invite.find_with_user_constraint(params[:id],current_user).destroy!
        respond_with(nil)
    end

    private

    # Never trust parameters from the scary internet, only allow the white list through.
    def invite_params
       params.permit(:email)
    end
end
