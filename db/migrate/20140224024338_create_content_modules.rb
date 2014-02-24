class CreateContentModules < ActiveRecord::Migration
  def change
    create_table :content_modules do |t|
      t.string :title, null: false
      t.string :context, null: false
      t.integer :position, null: false, default: 1
    end
  end
end
