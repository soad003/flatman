class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.timestamps
    end
  end
end
