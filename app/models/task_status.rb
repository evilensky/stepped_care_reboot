# Holds the completion status of a task for each participant
class TaskStatus < ActiveRecord::Base
  belongs_to :membership
  belongs_to :task, dependent: :destroy

  delegate  :title,
            :bit_player_content_module,
            :bit_player_content_module_id,
            to: :task

  scope :for_content_module, lambda { |m|
    joins(:task)
    .where(tasks: { bit_player_content_module_id: m.id })
  }
  scope :for_content_modules, lambda { |ids|
    joins(:task)
    .where(tasks: { bit_player_content_module_id: ids })
  }
end