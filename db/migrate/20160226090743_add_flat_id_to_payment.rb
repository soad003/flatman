class AddFlatIdToPayment < ActiveRecord::Migration
  def change
  	add_reference :payments, :flat, index: true, foreign_key: true
  end
end
