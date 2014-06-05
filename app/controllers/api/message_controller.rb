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
    @lastFlatChat = Message.getFlatChat(current_user)
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

  def getFlatMembers
    flat_users = User.where(flat_id: params[:flat_id])
    ret_users = Array.new
    flat_users.each do |user|
      ret_users = ret_users + [({text: user.name, id: user.id})]
    end
    respond_with({users: ret_users} )
  end

  def create
    recId = mes_params[:header]
    if (recId == "")
      respond_with_errors([t('.no_user_found')])
    elsif recId == "dub"
      respond_with_errors([t('.user_already_selected')])      
    else
      recIdArray = recId.lines(",")
      @newMess = Message.createMessages(recIdArray, current_user, mes_params)
    end
  end

  def get_users
    @users = User.where.not(id: current_user.id, flat_id: nil)
  end

  def destroy
    Message.destroyMessages(params[:id], current_user)
    respond_with(nil)
  end

  def count_messages
    header = "flatchat" + current_user.flat_id.to_s
    if params[:mes_id] == nil
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
