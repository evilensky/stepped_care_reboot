class AddTypeToSlides < ActiveRecord::Migration
  def change
    add_column :slides, :type, :string
    add_column :slides, :options, :text
  end
end
