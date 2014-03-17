# A portion of the Application with distinct functionality.
class AppSection
  SECTIONS = {
    thought_tracker: 'THINK',
    feeling_tracker: 'FEEL',
    activity_tracker: 'DO',
    library: 'LEARN',
    messages: 'MESSAGES'
  }

  attr_reader :slug

  def self.by_name(name)
    new(name)
  end

  def self.all
    SECTIONS.keys.map { |s| by_name(s) }
  end

  def initialize(name)
    @slug = name.to_s || ''
  end

  def label
    SECTIONS[slug.to_sym]
  end

  def content_modules
    BitPlayer::ContentModule.where(context: slug)
  end
end
