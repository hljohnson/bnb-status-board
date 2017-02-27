class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :client
      t.integer :owner_id
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
