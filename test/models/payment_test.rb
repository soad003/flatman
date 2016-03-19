require 'test_helper'

class PaymentTest < ActiveSupport::TestCase
  test 'do not save a payment without payer_id' do
    payment = Payment.new(value: 1, payee_id: 1)
    assert_not payment.save
  end

  test 'do not save a payment without payee_id' do
    payment = Payment.new(value: 1, payer_id: 2)
    assert_not payment.save
  end
end
