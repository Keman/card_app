class AddStreakToCards < ActiveRecord::Migration
  def change
    change_table :cards do |t|
      t.integer :lucky_streak, default: 0
      t.integer :losing_streak, default: 0
    end
  end
end
