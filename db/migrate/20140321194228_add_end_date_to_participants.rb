class AddEndDateToParticipants < ActiveRecord::Migration
  def change
    add_column :participants, :end_date, :datetime
  end
end
