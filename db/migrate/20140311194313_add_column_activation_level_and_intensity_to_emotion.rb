class AddColumnActivationLevelAndIntensityToEmotion < ActiveRecord::Migration
  def change
    remove_column :emotions, :type
    add_column :emotions, :activation_level, :integer
    add_index :emotions, :activation_level
    add_column :emotions, :intensity, :integer
    add_index :emotions, :intensity
  end
end
