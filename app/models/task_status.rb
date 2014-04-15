# Holds the completion status of a task for each participant
class TaskStatus < ActiveRecord::Base
  belongs_to :membership
  has_one :participant, through: :membership
  belongs_to :task

  delegate  :bit_player_content_module,
            :bit_player_content_module_id,
            :release_day,
            :title,
            to: :task

  scope :for_content_module, lambda { |content_module|
    joins(:task)
    .where(tasks: { bit_player_content_module_id: content_module.id })
  }
  scope :for_content_module_ids, lambda { |ids|
    joins(:task)
    .where(tasks: { bit_player_content_module_id: ids })
  }
  scope :available, lambda { |membership|
    where("start_day = ?", membership.day_in_study)
  }
  scope :available_for_learning, lambda { |membership|
    where("start_day <= ?", membership.day_in_study)
  }

  def completed?
    !completed_at.nil?
  end
end