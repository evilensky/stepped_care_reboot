class ContentModule < ActiveRecord::Base
  has_many :providers, class_name: 'ContentProvider', dependent: :destroy

  validates :title, :context, :position, presence: true
  validates_numericality_of :position, greater_than_or_equal_to: 1

  def provider_position=(provider_position)
    @current_provider_position = provider_position
  end

  def current_content_provider
    providers[current_provider_position] || ContentProviders::Null.new
  end

  def current_provider_position
    @current_provider_position ||= 0
  end

  def has_more_providers?
    current_provider_position + 1 < providers.count
  end
end
