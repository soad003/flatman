class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
		t.integer 	:payer_id
    	t.float 	:value
    	t.integer	:payee_id
    	t.datetime 	:date
      t.timestamps
    end
  end
end
