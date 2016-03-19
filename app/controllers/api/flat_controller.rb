class Api::FlatController < Api::RestController
  around_action :wrap_in_transaction, only: [:create, :update]

  def index
    @flat = current_user.flat
  end

  def create
    if !current_user.has_flat?
      flat = Flat.create_with_user!(current_user, flat_params_name_only)
      unless params[:invites].nil?
        params[:invites].each do |inv_email|
          invite = Invite.create_invite_from_email(inv_email, current_user)
          UserMailer.invite(invite.email, current_user.flat.name, invite.token, current_user.flat.token).deliver
        end
      end
      respond_with(nil, location: api_flat_path(flat))
    else
      respond_with_errors([t('.already_in_flat')])
    end
  end

  def update
    flat = current_user.flat
    flat.update_attributes!(flat_params)
    respond_with(flat, location: api_flat_path(flat))
  end

  def join_flat
    if current_user.flat.nil?
      flat = Flat.find_by_token(flat_join_params[:token])
      if flat.nil?
        respond_with_errors([t('.flat_key_not_found')])
      else
        flat.add_user(current_user)
        Newsitem.addUser(current_user)
        respond_with(nil, location: api_flat_path(nil))
      end
    else
      respond_with_errors([t('.already_in_flat')])
    end
  end

  def leave_flat
    balance = Finance.get_overview_mates(current_user, 0, 0)
    if balance.any? { |mate| mate.value.round(2) != 0.0 }
      respond_with_errors([t('.balance_not_zero')])
    else
      Newsitem.deleteUser(current_user)
      current_user.flat_id = nil
      current_user.flat = nil
      current_user.save!
      logout
      respond_with(nil, location: api_flat_path(nil))
    end
  end

  def flat_mates
    @mates = current_user.flat.users
  end

  def former_flat_mates
    @mates = nil
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def flat_params
    params.permit(:name, :invites, :street, :city, :zip)
  end

  def flat_params_name_only
    params.permit(:name)
  end

  def flat_join_params
    params.permit(:token)
  end
end
