class ChangeDataTypeForRessourceentryDescription < ActiveRecord::Migration
  def self.up
    change_table :ressources do |t|
      t.change :description, :string
    end
  end
  def self.down
    change_table :ressources do |t|
      t.change :description, :float
    end
  end
end
