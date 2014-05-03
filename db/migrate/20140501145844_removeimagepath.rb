class Removeimagepath < ActiveRecord::Migration
  def change
    remove_column :shareditems, :image_path
  end
end
