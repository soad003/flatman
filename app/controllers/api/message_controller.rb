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
    recId = mes_params[:receiver_id]
    if (recId == "")
      respond_with_errors([t('.no_user_found')])
    else
      @mes=Message.new(mes_params)
      user.sentMessages << @mes
      user.save!
      @mes
    end
  end

  def get_users
    @users = User.all
  end

  def destroy
    recId = Message.find(params[:id]).receiver_id
    senId = Message.find(params[:id]).sender_id
    m = Message.where(receiver_id: recId, sender_id: senId)
    m.destroy_all
    @mesd = Message.find_chats(current_user)
  end

  private
  def mes_params
    params.permit(:sender_id, :receiver_id, :text, :header, :read)
  end

end
