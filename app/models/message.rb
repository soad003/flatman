class Message < ActiveRecord::Base
  belongs_to	:sender, class_name: 'User'
  belongs_to	:receiver, class_name: 'User'
  validates :sender_id, :receiver_id, :text, presence: true

  def self.find_messages(mesId, current_user, quantity)
    retList = []
    header = 'flatchat' + current_user.flat_id.to_s
    if Message.find(mesId).header == header
      retList = Message.where('header = ?', header)
      retList.each do |m|
        unless m.readers.include?(current_user.id)
          m.readers = m.readers + [current_user.id]
          m.save!
        end
      end
    else
      user = Message.find(mesId).sender_id
      user2 = Message.find(mesId).receiver_id
      mesL = Message.where('sender_id = ? AND receiver_id = ?', user, user2)
      mesL2 = Message.where('sender_id = ? AND receiver_id = ?', user2, user)
      messList = mesL + mesL2
      messList.each do |mes|
        retList << mes unless mes.deleted.include?(current_user.id)
      end
    end
    retList = retList.sort! { |a, b| a.created_at <=> b.created_at }
    if quantity.to_i != -1 && (retList.length - quantity.to_i) > 0
      retList = retList.drop(retList.length - quantity.to_i)
    end
    retList
  end

  def self.find_partner(mesId, current_user)
    if mesId != '0' # first flatchat message
      user = Message.find(mesId).sender_id
      user2 = Message.find(mesId).receiver_id
      retUser = if user == current_user.id
                  user2
                else
                  user
                end

      ret = if user == user2
              { id: user, name: User.find(user).flat.name }
            else
              { id: retUser, name: User.find(retUser).name }
            end
    else
      ret = { id: current_user.id, name: User.find(current_user.id).flat.name }
    end
    ret
  end

  def self.find_chats(user)
    # all messages with me as sender
    header = 'flatchat' + user.flat_id.to_s
    mesL = Message.where('sender_id = ? AND header != ?', user.id, header)
    # all messages with me as receiver
    mesL2 = Message.where('receiver_id = ? AND header != ?', user.id, header)
    messList = mesL.clone + mesL2.clone
    helpList = []
    messList.each do |mes|
      helpList << mes unless mes.deleted.include?(user.id)
    end
    # sort by newest
    helpList.sort! { |a, b| b.created_at <=> a.created_at }
    # create array with sender, receiver pair
    returnList = []
    pairs = []
    helpList.each do |mes|
      mes.receiver_id = mes.receiver_id.to_s
      mes.sender_id = mes.sender_id.to_s
      next if pairs.include?([mes.receiver_id, mes.sender_id])
      newpair = []
      newpair[0] = mes.sender_id
      newpair[1] = mes.receiver_id
      pairs << newpair
      newpair2 = []
      newpair2[0] = mes.receiver_id
      newpair2[1] = mes.sender_id
      pairs << newpair2
    end
    # remove old messages
    helpList.each do |mes|
      next unless pairs.include?([mes.receiver_id, mes.sender_id])
      returnList << mes
      pairs.delete([mes.receiver_id, mes.sender_id])
      pairs.delete([mes.sender_id, mes.receiver_id])
    end
    returnList
  end

  def self.countUnread(counterList, current_user)
    count = '0'
    counterList.each do |c|
      if c.read == false
        count = (count.to_i + 1).to_s if c.sender_id != current_user.id
      end
    end
    count
  end

  def self.countFlatChatUnread(counterList, current_user)
    count = '0'
    counterList.each do |c|
      count = (count.to_i + 1).to_s unless c.readers.include?(current_user.id)
    end
    count
  end

  def self.getFlatChat(current_user)
    header = 'flatchat' + current_user.flat_id.to_s
    @flatChat = Message.where('header = ?', header)
    @flatChat.sort! { |a, b| a.created_at <=> b.created_at }
    @lastFlatChat = @flatChat.last
    if @lastFlatChat.nil?
      @lastFlatChat = Message.new(id: 0,
                                  sender_id: current_user.id,
                                  receiver_id: current_user.id,
                                  text: 'start chating with your flat members',
                                  header: '0',
                                  created_at: 0)
    end
    @lastFlatChat
  end

  def self.createMessages(recIdArray, current_user, mes_params)
    @newMess = []
    recIdArray.each do |rec|
      @mes = Message.new(mes_params)
      @mes.receiver_id = rec
      @mes.header = ''
      if rec == 'flatchat'
        header = 'flatchat' + current_user.flat_id.to_s
        @mes.header = header
        @mes.receiver_id = current_user.id
        @mes.sender_id = current_user.id
      end
      @mes.created_at = Message.calcTime
      @mes.readers = [current_user.id]
      @mes.deleted = []
      current_user.sentMessages << @mes.clone
      @newMess << @mes.clone
    end
    current_user.save!
    @newMess
  end

  def self.calcTime
    beginDate2014 = Time.new(2014, 3, 30, 2, 0)
    endDate2014 = Time.new(2014, 10, 26, 3, 0)
    beginDate2015 = Time.new(2015, 3, 29, 2, 0)
    endDate2015 = Time.new(2015, 10, 25, 3, 0)
    nowTime = Time.at(Time.now.to_i + 3600)
    if nowTime.between?(beginDate2014, endDate2014) || nowTime.between?(beginDate2015, endDate2015)
      return Time.at(nowTime.to_i + 3600)
    else
      return nowTime
    end
  end

  def self.destroyMessages(mess_id, current_user)
    recId = Message.find(mess_id).receiver_id
    senId = Message.find(mess_id).sender_id
    if current_user.id == senId || current_user.id == recId
      messages1 = Message.where(receiver_id: recId, sender_id: senId)
      messages2 = Message.where(sender_id: recId, receiver_id: senId)
      messages = messages1.clone + messages2.clone
      messages.each do |mess|
        unless mess.deleted.include?(current_user.id)
          mess.deleted = mess.deleted + [current_user.id]
          mess.save!
        end

        mess.destroy if mess.deleted.size > 1
      end
    end
  end
end
