class Emotion < ActiveRecord::Base

  belongs_to :participant
  
  validates :participant, presence: true
  validates :activation_level, presence: true, :inclusion => { :in => -5..5 }
  validates :intensity, presence: true, :inclusion => { :in => 0..10 }
  validates :rating, presence: true, :inclusion => { :in => -5..5 }

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
