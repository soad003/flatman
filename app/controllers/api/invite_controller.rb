class Api::InviteController < Api::RestController
  around_action :wrap_in_transaction, only: [:create, :destroy]

  def create
    invite = Invite.create_invite_from_email(invite_params[:email], current_user)
    UserMailer.invite(invite.email, current_user.flat.name, invite.token, current_user.flat.token).deliver
    @return = OpenStruct.new(already_registred: false, invite: invite)
  end

  def destroy
    Invite.find_with_user_constraint(params[:id], current_user).destroy!
    respond_with(nil)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def invite_params
    params.permit(:email)
  end
end
