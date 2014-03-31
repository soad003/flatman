class AddStartDateToRessources < ActiveRecord::Migration
  def change
    add_column :ressources, :startDate, :datetime
  end
end
