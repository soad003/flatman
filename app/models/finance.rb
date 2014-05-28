class Finance
	def self.get_user_tables (user)
		returnValue = []
		user.flat.users.each do |member|
			if (member.id != user.id)
				userTable = get_user_table(user, member)
				userTable.entries = userTable.entries.drop(0).take(5)
				returnValue << userTable
			end
		end
		returnValue
    end

    def self.get_user_table (user, member)
		member_info = OpenStruct.new({"name" => member.name, "page"=>1, "entryLength"=>"", "id" => member.id, "img_path" => member.image_path, "value" => 0, "entries" => []})

		paymentsUserToMember = Payment.where(payer_id: user.id, payee_id: member.id)
		member_info.entries = member_info.entries + getEntrysOfPayments(paymentsUserToMember, 1)
		paymentsMemberToUser = Payment.where(payer_id: member.id, payee_id: user.id)
		member_info.entries = member_info.entries + getEntrysOfPayments(paymentsMemberToUser, -1)
		billsPayedByUser = Bill.where(user_id: user.id, id: member.bills)
		member_info.entries = member_info.entries + getEntrysOfBills(billsPayedByUser, 1)
		billsUserHasToPay = Bill.where(user_id: member.id, id: user.bills)
		member_info.entries = member_info.entries + getEntrysOfBills(billsUserHasToPay, -1)

		member_info.entries.sort! {|a,b| b.date <=> a.date}
		member_info.entries.each do |entry| 
			member_info.value += entry.value
		end
		member_info.entryLength = member_info.entries.length
		member_info
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