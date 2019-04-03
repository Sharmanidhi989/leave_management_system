class AddHalfDayToLeaves < ActiveRecord::Migration[5.2]
  def change
    add_column :leaves, :half_day, :decimal, :default => 0
  end
end
