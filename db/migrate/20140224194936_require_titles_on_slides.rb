class RequireTitlesOnSlides < ActiveRecord::Migration
  def change
    change_column_null :slides, :title, false
  end
end
