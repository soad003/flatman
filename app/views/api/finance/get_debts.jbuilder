json.array!(@pmnt) do |payment|
	#json.payer_id payment.payer_id
	#json.payee_id payment.payee_id
	json.id payment.id
	json.debt payment.value
	json.payer_name payment.payer.name
	json.payee_name payment.payee.name
end
