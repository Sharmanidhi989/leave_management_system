class AddDefaultToLeaves < ActiveRecord::Migration[5.2]
  def change
    change_column :leaves, :status, :integer
  end
end