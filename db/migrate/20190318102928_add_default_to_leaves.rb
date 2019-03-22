class AddDefaultToLeaves < ActiveRecord::Migration[5.2]
  def change
    # change_column :leaves, :status, :integer
    change_column :leaves, :status, 'integer USING CAST(status AS integer)'
  end
end