class AppSection
  SECTIONS = {
    thought_tracker: 'THINK',
    feeling_tracker: 'FEEL',
    activity_tracker: 'DO',
    library: 'LEARN',
    messages: 'MESSAGES'
  }

  def self.by_name(name)
    new(name)
  end

  def self.all
    SECTIONS.keys.map { |s| by_name(s) }
  end

  def initialize(name)
    @name = name.to_s || ''
  end

  def slug
    @name
  end

  def label
    SECTIONS[@name.to_sym]
  end

  def content_modules
    ContentModule.where(context: @name)
  end
end
