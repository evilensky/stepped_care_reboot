class ParticipantStatus < ActiveRecord::Base
  belongs_to :participant

  def initialize_context(name)
    self.context = name
    self.module_position = 1
    self.provider_position = 1
    self.content_position = 1
  
    save
  end

  def increment_content_position
    self.content_position += 1

    save
  end

  def increment_provider_position
    self.provider_position += 1
    self.content_position = 1

    save
  end
end
