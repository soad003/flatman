class CreateNewsitemcategories < ActiveRecord::Migration
  def change
    create_table :newsitemcategories do |t|
      t.string      :name
      t.timestamps
    end
  end
end
