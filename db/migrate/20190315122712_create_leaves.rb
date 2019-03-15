class CreateLeaves < ActiveRecord::Migration[5.2]
  def change
    create_table :leaves do |t|
      t.references :employee, foreign_key: true
      t.string :status
      t.date :to
      t.date :from
      t.text :reason
      t.string :category

      t.timestamps
    end
  end
end
