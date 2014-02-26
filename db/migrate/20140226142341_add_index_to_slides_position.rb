class AddIndexToSlidesPosition < ActiveRecord::Migration
  def change
    add_index :slides, [:position, :slideshow_id], unique: true
  end
end
