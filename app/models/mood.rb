class Mood < ActiveRecord::Base
  belongs_to :participant
  
  validates :participant, presence: true
  validates :rating, presence: true, :inclusion => { :in => -5..5 }

  def mood_value
    Values::Mood.from_rating(rating).to_s
  end

end
