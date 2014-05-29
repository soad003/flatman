class Api::MessageController < Api::RestController
  
  around_filter :wrap_in_transaction, only: [:create]

  def index
    @meslist=Message.find_chats(current_user)
  end

  def get_messages
    if params[:id] != nil && params[:id] != "0"
      @meslist=Message.find_messages(params[:id], current_user)
      @meslist.each do |m|
        if !m.read && m.receiver_id == current_user.id
          m.read = true
          m.save!
        end
      end
    else
      @meslist = []
    end
    @meslist
  end

  def getFlatChat
    header = "flatchat" + current_user.flat_id.to_s
    @flatChat=Message.where("header = ?", header)
    @flatChat.sort! { |a,b| a.created_at <=> b.created_at }
    @lastFlatChat = @flatChat.last
    if @lastFlatChat == nil
      @lastFlatChat = Message.new({id: 0, sender_id: current_user.id, receiver_id: current_user.id, text: "start chating with your flat members", header: "0", created_at: 0})
    end
    @lastFlatChat
  end

  def find_partner
    @partner=Message.find_partner(params[:mes_id], current_user)
  end

  def find_active_chat
    ret = Message.find(params[:mes_id]).header == "flatchat" + current_user.flat_id.to_s
    respond_with({active: ret})
  end

  def getUserId
    respond_with({id: current_user.id})
  end

  def create
    recId = mes_params[:receiver_id]
    if (recId == "")
      respond_with_errors([t('.no_user_found')])
    else
      @mes=Message.new(mes_params)
      if mes_params[:header] == "flatchat"
        header = "flatchat" + current_user.flat_id.to_s
        @mes.header = header
        @mes.receiver_id = current_user.id
        @mes.sender_id = current_user.id
      end
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
      @mes.readers = [current_user.id]
      @mes.deleted = []
      current_user.sentMessages << @mes
      current_user.save!
      @mes
    end
  end

  def get_users
    @users = User.where.not(id: current_user.id, flat_id: nil)
  end

  def destroy
    recId = Message.find(params[:id]).receiver_id
    senId = Message.find(params[:id]).sender_id
    m1 = Message.where(receiver_id: recId, sender_id: senId)
    m2 = Message.where(sender_id: recId, receiver_id: senId)
    m = m1.clone + m2.clone
    m.each do |mess| 
      if !mess.deleted.include?(current_user.id)
        mess.deleted = mess.deleted + [current_user.id]
        mess.save!
      end

      if mess.deleted.size > 1
        mess.destroy
      end
    end
    @mesd = Message.find_chats(current_user)
  end

  def count_messages
    header = "flatchat" + current_user.flat_id.to_s
    if params[:mes_id] == nil
    #if Message.find(params[:mes_id]).header == header
      @counterList = Message.where("header = ?", header)
      @counter = Message.countFlatChatUnread(@counterList, current_user)
      respond_with({counter: @counter})
    else
      @counterList = Message.find_messages(params[:mes_id], current_user)
      @counter = Message.countUnread(@counterList, current_user)
      respond_with({counter: @counter})
    end
  end

  private
  def mes_params
    params.permit(:sender_id, :receiver_id, :text, :header, :read, :readers, :deleted)
  end

end
