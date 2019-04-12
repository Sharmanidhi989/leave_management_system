class AddReferencesToAlerts < ActiveRecord::Migration[5.2]
  def change
    add_reference :alerts, :employee, foreign_key: true
  end
end
