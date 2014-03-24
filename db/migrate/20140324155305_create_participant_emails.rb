class CreateParticipantEmails < ActiveRecord::Migration
  def change
    create_table :participant_emails do |t|
      t.references :participant
      t.string :email_type
      t.datetime :last_email
      t.boolean :enabled

      t.timestamps
    end
    add_index :participant_emails, :participant_id
  end
end
