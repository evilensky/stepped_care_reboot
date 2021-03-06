# Participants rate their emotions with valence and intensity
class Emotion < ActiveRecord::Base
  belongs_to :participant
  validates :participant, presence: true
  validates :valence, presence: true, inclusion: { in: -1..1 }
  validates :rating, presence: true, inclusion: { in: 0..10 }

  def intensity_value
    Values::Emotion.from_intensity(intensity).to_s
  end

  def rating_value
    Values::Emotion.from_rating(rating).to_s
  end
end
