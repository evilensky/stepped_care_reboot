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
  delegate :title, to: :bit_player_content_module, null: false

  private

  def assign_task_status_to_each_participant
    group.memberships.each do |membership|
      TaskStatus.create!(membership_id: membership.id, task_id: id)
    end
  end
end