class CreateInvites < ActiveRecord::Migration
  def change
    create_table :invites do |t|
      t.string :email
      t.belongs_to  :flat

      t.timestamps
    end
  end
end
