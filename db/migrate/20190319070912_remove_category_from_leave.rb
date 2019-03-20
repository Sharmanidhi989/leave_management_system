class RemoveCategoryFromLeave < ActiveRecord::Migration[5.2]
  def change
    remove_column :leaves, :category, :string
  end
end
