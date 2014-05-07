class Api::MessageController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create]

  def index
    @meslist=Message.find_chats(current_user)
  end

  def get_messages
    @meslist=Message.find_messages(params[:mes_id])
    @meslist.each do |m|
      if !m.read && m.receiver_id == current_user.id
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
      beginDate2014 = Time.new(2014,3,30,2,0)
      endDate2014 = Time.new(2014,10,26,3,0)
      beginDate2015 = Time.new(2015,3,29,2,0)
      endDate2015 = Time.new(2015,10,25,3,0)
      nowTime = Time.at(Time.now.to_i + 3600)
      if nowTime.between?(beginDate2014, endDate2014) || nowTime.between?(beginDate2015, endDate2015)
        @mes.created_at = Time.at(nowTime.to_i + 3600)
      else 
        @mes.created_at = nowTime
      end
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
    @counter = Message.countUnread(@counterList, current_user)
    respond_with({counter: @counter})
  end

  private
  def mes_params
    params.permit(:sender_id, :receiver_id, :text, :header, :read)
  end

end
