# Collected responses from one Participant PHQ-9 assessment session.
class PhqAssessment < ActiveRecord::Base
  belongs_to :participant

  validates :participant, :release_date, presence: true
end
