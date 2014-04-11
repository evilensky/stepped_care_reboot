class AddRecurringToTaskStatuses < ActiveRecord::Migration
  def change
    add_column :task_statuses, :is_recurring, :boolean, default: false, null: false
  end
end
