class Slideshow < ActiveRecord::Base
  has_many :slides, dependent: :destroy
  has_one :content_provider, as: :source_content, inverse_of: :source_content

  validates :title, presence: true
end
