class CreateLeaveQuota < ActiveRecord::Migration[5.2]
  def change
    create_table :leave_quota do |t|
      t.string :leave_category
      t.integer :leave_number
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
