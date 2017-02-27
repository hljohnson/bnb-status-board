class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :description
      t.datetime :due_at
      t.datetime :completed_at
      t.integer :project_id
      t.integer :owner_id
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
