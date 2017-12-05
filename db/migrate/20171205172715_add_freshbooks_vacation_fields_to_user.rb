class AddFreshbooksVacationFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :freshbooks_api_key, :string
    add_column :users, :max_vacation_hours, :float
  end
end
