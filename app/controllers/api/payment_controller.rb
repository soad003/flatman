class Api::PaymentController < Api::RestController
  def create
    payment = Payment.new(entry_params)
    payment.payee_id = current_user.id
    payment.flat = current_user.flat
    payment.save!
    Newsitem.createPayment(payment, current_user)
    respond_with(nil, location: nil)
  end

  def destroy
    payment = Payment.find_with_user_constraint(delete_params[:id], current_user, User.find(delete_params[:mate_id]))
    if payment.is_editable?
      Newsitem.deletePayment(payment, current_user)
      payment.destroy!
      respond_with(nil, location: nil)
    else
      respond_with_errors([t('.no_edit_deleted_users')])
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def entry_params
    params.permit(:date, :value, :payer_id)
  end

  def delete_params
    params.permit(:id, :mate_id, :page)
  end
end
