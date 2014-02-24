class Slideshow < ActiveRecord::Base
  has_many :slides, dependent: :destroy

  validates :title, presence: true
end
