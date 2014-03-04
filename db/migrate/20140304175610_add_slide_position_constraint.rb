class AddSlidePositionConstraint < ActiveRecord::Migration
  
  def up
    remove_index :slides, [:position, :slideshow_id]
    add_index :slides, [:position, :slideshow_id]
    execute <<-SQL
      alter table slides
        add constraint slide_position unique (slideshow_id, position)
        DEFERRABLE INITIALLY IMMEDIATE;
    SQL
  end

  def down
    execute <<-SQL
      alter table slides
        drop constraint if exists slide_position;
    SQL
    remove_index :slides, [:position, :slideshow_id]
    add_index :slides, [:position, :slideshow_id], unique: true
  end

end
