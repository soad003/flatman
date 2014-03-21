class CreateBillsUsers < ActiveRecord::Migration
  def change
    create_table :bills_users do |t|
    	t.integer 	:user_id
    	t.integer	:bill_id
    end
  end
end
