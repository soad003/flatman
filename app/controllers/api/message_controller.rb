class Api::MessageController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create]

  def index
    @meslist=Message.find_chats(current_user)
  end

  def get_messages
    @meslist=Message.find_messages(params[:mes_id])
  end

  def find_partner
    @partner=Message.find_partner(params[:mes_id], current_user)
  end

  def create
    user=current_user
    @mes=Message.new(mes_params)
    user.sentMessages << @mes
    user.save!
    @mes
  end

  def get_users
    @users = User.all
  end

  private
  def mes_params
    params.permit(:sender_id, :receiver_id, :text, :header, :read)
  end

end
