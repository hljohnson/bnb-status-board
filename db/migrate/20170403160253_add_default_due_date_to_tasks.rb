class AddDefaultDueDateToTasks < ActiveRecord::Migration
  def change
  	change_column_default :tasks, :due_at, Time.now + 7.days
  end
end
