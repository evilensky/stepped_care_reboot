# Gives participants notifications on what needs to be completed
class Task < ActiveRecord::Base
  belongs_to :group
  belongs_to :bit_player_content_module, class_name: "BitPlayer::ContentModule"
  belongs_to :creator, class_name: "User"
  after_create :assign_task_status_to_each_participant
  validates :release_day,
            uniqueness: {
              scope: [:bit_player_content_module, :group],
              message: %q(This task has already been assigned and set to be released on this day to this group.)
            }

  # scope :for_participant, lambda { |p| joins(:group => :memberships).where(:memberships => {:participant_id => p.id }) }
  # scope :is_completed_for_participant, lambda { |p| where(is_complete: true).for_participant(p) }
  # scope :to_be_completed_by_participant, lambda { |p| where(is_complete: false).for_participant(p) }

  private

  def assign_task_status_to_each_participant
    self.group.memberships.each do |membership|
      TaskStatus.create!(membership_id: membership.id, task_id: self.id)
    end
  end

end