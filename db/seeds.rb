# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
ActiveRecord::Base.transaction do
  content_module = BitPlayer::ContentModule.find_by_title("Lessons")
  ["slideshows.csv"].each do |file|
    CSV.foreach(File.join(Rails.root, "db", file), headers: true) do |row|
      ss = BitPlayer::Slideshow.new(title: row[1])
      if ss.save!
        content_provider = BitPlayer::ContentProvider.new(
          type: "BitPlayer::ContentProviders::SlideshowProvider",
          source_content_type: "BitPlayer::Slideshow",
          source_content_id: ss.id,
          bit_player_content_module_id: content_module.id,
          position: content_module.content_providers.count + 1
        )
        unless content_provider.save!
          fail "There were errors: #{content_provider.errors.full_messages}"
        end
      else
        fail "There were errors: #{ss.errors.full_messages}"
      end
    end
  end
end

ActiveRecord::Base.transaction do
  ["slides.csv"].each do |file|
    CSV.foreach(File.join(Rails.root, "db", file), headers: true) do |row|
      s = BitPlayer::Slide.new(
        title: row[2] || "Untitled",
        body: row[3],
        position: row[1].to_i,
        bit_player_slideshow_id: BitPlayer::Slideshow.find_by_title(row[0].to_s).id,
        is_title_visible: !row[2].nil?
      )
      unless s.save!
        fail "There were errors: #{s.errors.full_messages}"
      end
    end
  end
end