# Gives participants notifications on what needs to be completed
class Task < ActiveRecord::Base
  belongs_to :group
  belongs_to :bit_player_content_module, class_name: "BitPlayer::ContentModule"
  belongs_to :creator, class_name: "User"
  validates :is_recurring, inclusion: { in: [true, false] }
  has_many :task_statuses, dependent: :destroy
  after_create :assign_task_status_to_each_participant
  validates :release_day,
            uniqueness: {
              scope: [:bit_player_content_module, :group],
              message: %q(
                This task has already been assigned and set
                to be released on this day to this group.
              )
            },
            presence: true

  delegate :title, to: :bit_player_content_module, null: false

  private

  def assign_task_status_to_each_participant
    group.memberships.each do |membership|
      if is_recurring
        days_of_study = (membership.end_date - membership.start_date.to_date)
        days = *(release_day..days_of_study)
        days.each do |day|
          TaskStatus.create!(membership_id: membership.id, task_id: id, start_day: release_day + day)
        end
      else
        TaskStatus.create!(membership_id: membership.id, task_id: id, start_day: release_day)
      end
    end
  end
end