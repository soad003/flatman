class Api::PaymentController < Api::RestController

    def create
        payment = Payment.new(entry_params)
        payment.payee_id = current_user.id
        payment.save!
        respond_with(nil, :location => nil)
    end

    def destroy
        payment = Payment.find(delete_params[:id])
        if payment.payee_id == current_user.id || payment.payer_id == current_user.id
            payment.destroy!
            respond_with(nil, :location => nil)
        end
    end

    private
    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
          params.permit(:date, :value, :payer_id)   
    end

    def delete_params
          params.permit(:id, :member_id, :page)
    end

end
