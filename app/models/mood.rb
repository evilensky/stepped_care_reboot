class Mood < ActiveRecord::Base
  belongs_to :participant
  
  validates :participant, presence: true
  validates :rating, presence: true
end
