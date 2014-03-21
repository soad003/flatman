class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
		t.integer	:sender_id
    	t.integer	:receiver_id
    	t.string 	:text
    	t.string	:header
    	t.boolean	:read
      t.timestamps
    end
  end
end
