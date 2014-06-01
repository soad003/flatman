class Finance
	def self.get_overview_mates (user, from, to)
		returnValue = []
		user.flat.users.each do |mate|
			if (mate.id != user.id)
				overview_mate = get_overview_mate(user, mate)
				overview_mate.entries = overview_mate.entries.drop(from).take(to)
				returnValue << overview_mate
			end
		end
		returnValue
    end

    def self.get_overview_mate (user, mate)
		mate_info = OpenStruct.new({"name" => mate.name, "page"=>1, "entryLength"=>"", "id" => mate.id, "img_path" => mate.image_path, "value" => 0, "entries" => []})

		paymentsUserToMate = Payment.where(payer_id: user.id, payee_id: mate.id)
		mate_info.entries = mate_info.entries + getEntrysOfPayments(paymentsUserToMate, 1)
		paymentsMateToUser = Payment.where(payer_id: mate.id, payee_id: user.id)
		mate_info.entries = mate_info.entries + getEntrysOfPayments(paymentsMateToUser, -1)
		billsPayedByUser = Bill.where(user_id: user.id, id: mate.bills)
		mate_info.entries = mate_info.entries + getEntrysOfBills(billsPayedByUser, 1)
		billsUserHasToPay = Bill.where(user_id: mate.id, id: user.bills)
		mate_info.entries = mate_info.entries + getEntrysOfBills(billsUserHasToPay, -1)

		mate_info.entries.sort! {|a,b| b.date <=> a.date}
		mate_info.entries.each do |entry| 
			mate_info.value += entry.value
		end
		mate_info.entryLength = mate_info.entries.length
		mate_info
    end

    def self.getEntrysOfPayments (payments, sign)
    	list = []
    	payments.each do |payment|
    		list << OpenStruct.new({"id" => payment.id, "date" => payment.date,"what" => "Payment","value" => (payment.value*sign)})
    	end
    	list
    end

    def self.getEntrysOfBills (bills, sign)
    	list = []
    	bills.each do |bill|
    		partialAmount = bill.value / bill.users.length
    		list << OpenStruct.new({"id" => -1, "date" => bill.date,"what" => bill.text, "value" => partialAmount*sign})
    	end
    	list
    end
end