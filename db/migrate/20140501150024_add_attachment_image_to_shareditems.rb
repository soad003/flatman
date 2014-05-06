class AddAttachmentImageToShareditems < ActiveRecord::Migration
  def self.up
    change_table :shareditems do |t|
      t.attachment :image
    end
  end

  def self.down
    drop_attached_file :shareditems, :image
  end
end
