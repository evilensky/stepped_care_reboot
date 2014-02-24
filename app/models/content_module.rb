class ContentModule < ActiveRecord::Base
  has_many :providers, -> { order 'position' }, class_name: 'ContentProvider', dependent: :destroy

  validates :title, :context, :position, presence: true
  validates_numericality_of :position, greater_than_or_equal_to: 1

  def provider(position)
    providers.where(position: position).first || ContentProviders::Null.new
  end

  def provider_exists?(position)
    providers.exists?(position: position)
  end
end
