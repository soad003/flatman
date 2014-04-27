class Api::MessageController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create]

  def index
    #@meslist=Message.find_messages(current_user, 1)
    @meslist=Message.find_chats(current_user)
    respond_with(@meslist)
  end

  def create
    user=current_user
    recName = mes_params[:receiver_id]
    recvID = User.find_by_name(recName).id
    mes=Message.new(mes_params)
    mes.receiver_id = recvID
    user.sentMessages << mes
    user.save!
    respond_with(mes, :location => nil);
  end

  private
  def mes_params
    params.permit(:sender_id, :receiver_id, :text, :header, :read)
  end

end
