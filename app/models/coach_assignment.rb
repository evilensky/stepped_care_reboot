class CoachAssignment < ActiveRecord::Base
  belongs_to :participant
  belongs_to :coach, class_name: 'User', inverse_of: :coach_assignment
end
