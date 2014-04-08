# Holds the completion status of a task for each participant
class TaskStatus < ActiveRecord::Base
  belongs_to :membership
  belongs_to :task, dependent: :destroy

  delegate :title, to: :task

  scope :for_content_module, lambda { |m| joins(:task).where(:tasks => {:bit_player_content_module_id => m.id }) }
  scope :for_content_modules, lambda { |ids| joins(:task).where(:tasks => {:bit_player_content_module_id => ids }) }
  scope :for_participant, lambda { |p| joins(:membership).where(:memberships => {:participant_id => p.id }) }
  scope :is_completed_for_participant, lambda { |p| where.not(completed_at: nil).for_participant(p) }
  scope :to_be_completed_by_participant, lambda { |p| where(completed_at: nil).for_participant(p) }
  scope :today, lambda { |p| joins(:task).where("tasks.release_day = ?", p.memberships.first.day_in_study).to_be_completed_by_participant(p) }

  def self.to_complete(participant, content_modules)
    TaskStatus
      .today(participant)
      .for_content_modules(content_modules.map(&:id))
  end
end