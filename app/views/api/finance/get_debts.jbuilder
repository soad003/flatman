json.array!(@pmnt) do |json, payment|
	#json.payer_id payment.payer_id
	#json.payee_id payment.payee_id
	json.debt payment.value
	json.payer_name User.find(payment.payer_id).name
	json.payee_name User.find(payment.payee_id).name
end