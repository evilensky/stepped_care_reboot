# Collected responses from one Participant PHQ-9 assessment session.
class PhqAssessment < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :release_date, presence: true
  validates :release_date, uniqueness: { scope: :participant_id }

  def score
    q1 + q2 + q3 + q4 + q5 + q6 + q7 + q8 + q9
  end
end
