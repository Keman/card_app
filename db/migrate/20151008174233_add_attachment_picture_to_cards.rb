class AddAttachmentPictureToCards < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.attachment :picture
    end
  end
end
