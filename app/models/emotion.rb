class Emotion < ActiveRecord::Base

  belongs_to :participant
  
  validates :participant, presence: true
  validates :rating, presence: true

end
