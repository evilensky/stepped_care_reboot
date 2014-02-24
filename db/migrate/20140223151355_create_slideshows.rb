class CreateSlideshows < ActiveRecord::Migration
  def change
    create_table :slideshows do |t|
      t.string :title, null: false

      t.timestamps
    end
  end
end
