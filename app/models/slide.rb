class Slide < ActiveRecord::Base
  belongs_to :slideshow, inverse_of: :slides

  validates :title, :body, :position, presence: true
  validates_numericality_of :position, greater_than_or_equal_to: 1
end
