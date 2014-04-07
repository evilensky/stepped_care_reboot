# Holds the completion status of a task for each participant
class TaskStatus < ActiveRecord::Base
  belongs_to :membership
  belongs_to :task, dependent: :destroy

  # scope :for_participant, lambda { |p| joins(:membership).where(:memberships => {:participant_id => p.id }) }
end