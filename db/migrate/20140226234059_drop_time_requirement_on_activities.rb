class DropTimeRequirementOnActivities < ActiveRecord::Migration
  def change
    change_column_null :activities, :start_time, true
    change_column_null :activities, :end_time, true
  end
end
