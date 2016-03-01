class CreateNewsitems < ActiveRecord::Migration
  def change
    create_table :newsitems do |t|
      t.string      :text
      t.string      :header
      t.belongs_to  :user
      t.belongs_to  :newsitemcategory
      t.belongs_to  :flat
      t.belongs_to  :newsitem
      t.timestamps
    end
  end
end
