class ChangeLeaveNumberToDecimalInLeaveQuota < ActiveRecord::Migration[5.2]
  def change
    add_column :leave_quota, :count, :decimal
    remove_column :leave_quota, :leave_number, :integer
  end
end
