class Finance
  def self.get_overview_mates(user, from, to)
    (user.flat.users.map do |mate|
       next unless mate.id != user.id
       overview_mate = get_overview_mate(user, mate)
       overview_mate.entries = overview_mate.entries.sort { |a, b| b.date <=> a.date }
       overview_mate.entries = overview_mate.entries.drop(from).take(to)
       overview_mate
     end).compact
  end

  def self.get_overview_mate(user, mate)
    mate_info = OpenStruct.new('name' => mate.username,
                               'page' => 1,
                               'entryLength' => '',
                               'id' => mate.id,
                               'img_path' => mate.image_path,
                               'value' => 0,
                               'entries' => [])

    paymentsUserToMate = Payment.where(payer_id: user.id, payee_id: mate.id, flat_id: user.flat_id)
    mate_info.entries = mate_info.entries + getEntrysOfPayments(paymentsUserToMate, 1)
    paymentsMateToUser = Payment.where(payer_id: mate.id, payee_id: user.id, flat_id: user.flat_id)
    mate_info.entries = mate_info.entries + getEntrysOfPayments(paymentsMateToUser, -1)
    billsPayedByUser = Bill.where(user_id: user.id, id: mate.bills, flat_id: user.flat_id)
    mate_info.entries = mate_info.entries + getEntrysOfBills(billsPayedByUser, 1)
    billsUserHasToPay = Bill.where(user_id: mate.id, id: user.bills, flat_id: user.flat_id)
    mate_info.entries = mate_info.entries + getEntrysOfBills(billsUserHasToPay, -1)

    mate_info.entries.each do |entry|
      mate_info.value += entry.value
    end
    mate_info.entryLength = mate_info.entries.length
    mate_info
  end

  def self.getEntrysOfPayments(payments, sign)
    list = []
    payments.each do |payment|
      py_str = I18n.t('templates.finances.payment')
      py_text = payment.description.blank? ? py_str : py_str + ': ' + payment.description
      list << OpenStruct.new('isPayment' => true,
                             'id' => payment.id,
                             'payer_id' => payment.payer.id,
                             'date' => payment.date,
                             'created_at' => payment.created_at,
                             'what' => py_text,
                             'total_price' => (payment.value * sign),
                             'value' => (payment.value * sign))
    end
    list
  end

  def self.getEntrysOfBills(bills, sign)
    list = []
    bills.each do |bill|
      partialAmount = bill.value / bill.users.length
      list << OpenStruct.new('isPayment' => false,
                             'id' => bill.id,
                             'payer_id' => bill.user.id,
                             'created_at' => bill.created_at,
                             'date' => bill.date,
                             'what' => bill.text,
                             'total_price' => bill.value,
                             'value' => partialAmount * sign)
    end
    list
  end
end
