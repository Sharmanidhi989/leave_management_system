class AddHasRequestedCancellationToLeaves < ActiveRecord::Migration[5.2]
  def change
    add_column :leaves, :has_requested_cancellation, :boolean, :default => false
  end
end
