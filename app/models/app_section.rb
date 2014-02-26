class AppSection
  def self.by_name(name)
    new(name)
  end

  def initialize(name)
    @name = name || ''
  end

  def label
    {
      activity_tracker: 'DO',
      thought_tracker: 'THINK',
      feelings_tracker: 'FEEL',
      library: 'LEARN',
      messages: 'MESSAGES'
    }[@name.to_sym]
  end
end
