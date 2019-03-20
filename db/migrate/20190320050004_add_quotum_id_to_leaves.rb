class AddQuotumIdToLeaves < ActiveRecord::Migration[5.2]
  def change
    add_column :leaves, :leave_quotum_id, :integer
  end
end
