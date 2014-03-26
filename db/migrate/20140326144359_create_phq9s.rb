class CreatePhq9s < ActiveRecord::Migration
  def change
    create_table :phq9s do |t|
      t.integer :q1
      t.integer :q2
      t.integer :q3
      t.integer :q4
      t.integer :q5
      t.integer :q6
      t.integer :q7
      t.integer :q8
      t.integer :q9
      t.references :participant, index: true

      t.timestamps
    end
  end
end
