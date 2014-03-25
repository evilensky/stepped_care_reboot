class AddStartDateToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :start_date, :datetime
  end
end
