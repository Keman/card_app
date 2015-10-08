class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.belongs_to :user, index: true
      t.text :original_text
      t.text :translated_text
      t.datetime :review_date

      t.timestamps null: false
    end
  end
end
