class Thought < ActiveRecord::Base
  EFFECTS = ['helpful', 'harmful', 'neither']

  belongs_to :participant

  validates :participant, :content, :effect, presence: true
  validates :effect, inclusion: { in: EFFECTS }
end
