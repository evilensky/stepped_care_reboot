class RequireTitlesOnSlides < ActiveRecord::Migration
  def change
    Slide.all.each do |slide|
      if slide.title.nil?
        slide.title = 'set me'
        slide.save!
      end
    end
    change_column :slides, :title, :string, null: false
  end
end
