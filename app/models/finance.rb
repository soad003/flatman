class Finance
	def self.getUserTables (user)
		returnValue = []
		user.flat.users.each do |member|
			if (member.id != user.id)
				member_info = OpenStruct.new({"name" => member.name, "id" => member.id, "img_path" => member.image_path, "value" => 0, "entries" => []})

				paymentsUserToMember = Payment.where(payer_id: user.id, payee_id: member.id)
				member_info.entries = member_info.entries + getEntrysOfPayments(paymentsUserToMember, 1)
				paymentsMemberToUser = Payment.where(payer_id: member.id, payee_id: user.id)
				member_info.entries = member_info.entries + getEntrysOfPayments(paymentsMemberToUser, -1)
				billsPayedByUser = Bill.where(user_id: user.id, id: member.bills)
				member_info.entries = member_info.entries + getEntrysOfBills(billsPayedByUser, 1)
				billsUserHasToPay = Bill.where(user_id: member.id, id: user.bills)
				member_info.entries = member_info.entries + getEntrysOfBills(billsUserHasToPay, -1)

				member_info.entries.sort! {|a,b| a.date <=> b.date}
				member_info.entries.each do |entry| 
					member_info.value += entry.value
				end
				member_info.entries = member_info.entries.slice(0,5);
				returnValue << member_info
			end
		end
		returnValue
    end

    def self.getEntrysOfPayments (payments, sign)
    	list = []
    	payments.each do |payment|
    		list << OpenStruct.new({"date" => payment.date,"what" => "Payment","value" => (payment.value*sign)})
    	end
    	list
    end

    def self.getEntrysOfBills (bills, sign)
    	list = []
    	bills.each do |bill|
    		partialAmount = bill.value / bill.users.length
    		list << OpenStruct.new({"date" => bill.date,"what" => bill.text, "value" => partialAmount*sign})
    	end
    	list
    end
end