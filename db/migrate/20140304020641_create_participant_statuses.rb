class CreateParticipantStatuses < ActiveRecord::Migration
  def change
    create_table :participant_statuses do |t|
      t.string :context
      t.integer :module_position
      t.integer :provider_position
      t.integer :content_position
      t.references :participant, index: true

      t.timestamps
    end
  end
end
