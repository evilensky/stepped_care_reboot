class CreateParticipantTokens < ActiveRecord::Migration
  def change
    create_table :participant_tokens do |t|
      t.references :participant, index: true
      t.datetime :release_date
      t.string :token_type
      t.string :token

      t.timestamps
    end
  end
end
