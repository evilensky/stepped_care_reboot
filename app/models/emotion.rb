class Emotion < ActiveRecord::Base

  belongs_to :participant
  
  validates :participant, presence: true
  validates :rating, presence: true


  def activation_level_value
    Values::Emotion.from_activation_level(activation_level).to_s
  end

  def intensity_value
    Values::Emotion.from_intensity(intensity).to_s
  end

  def rating_value
    Values::Emotion.from_rating(rating).to_s
  end


end
