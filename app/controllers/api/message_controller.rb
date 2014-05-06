class Api::MessageController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create]

  def index
    @meslist=Message.find_chats(current_user)
  end

  def get_messages
    @meslist=Message.find_messages(params[:mes_id])
    @meslist.each do |m|
      if !m.read
        m.read = true
        m.save!
      end
    end
    @meslist
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
      @mes.header = "0"
      user.sentMessages << @mes
      user.save!
      @mes
    end
  end

  def get_users
    @users = User.all
    @users.each do |user|
      if user.flat_id == nil
        @users.delete(user)
      end
    end
    @users
  end

  def destroy
    recId = Message.find(params[:id]).receiver_id
    senId = Message.find(params[:id]).sender_id
    m = Message.where(receiver_id: recId, sender_id: senId)
    m.destroy_all
    @mesd = Message.find_chats(current_user)
  end

  def count_messages
    @counterList = Message.find_messages(params[:mes_id])
    count = "0"
    @counterList.each do |c| 
      if c.read == false
        if c.sender_id != current_user.id
          count = (count.to_i + 1).to_s
        end
      end
    end
    m = Message.find(params[:mes_id])
    m.header = count
    @counter = m
  end

  private
  def mes_params
    params.permit(:sender_id, :receiver_id, :text, :header, :read)
  end

end
