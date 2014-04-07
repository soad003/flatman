class ChangeDataTypeForRessourceentry < ActiveRecord::Migration
  def self.up
    change_table :ressourceentries do |t|
      t.change :date, :date
    end
  end
  def self.down
    change_table :ressourceentries do |t|
      t.change :date, :datetime
    end
  end
end
