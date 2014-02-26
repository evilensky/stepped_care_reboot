class AddIsTitleVisibleToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :is_title_visible, :boolean, null: false, default: true
  end
end
