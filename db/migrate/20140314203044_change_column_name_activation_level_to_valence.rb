class ChangeColumnNameActivationLevelToValence < ActiveRecord::Migration
  def change
    remove_index :emotions, :activation_level
    remove_index :emotions, :intensity
    remove_index :emotions, :name
    rename_column :emotions, :activation_level, :valence
  end
end
