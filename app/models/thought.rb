class Thought < ActiveRecord::Base
  EFFECTS = ["helpful", "harmful", "neither"]

  belongs_to :participant
  belongs_to :pattern, class_name: "ThoughtPattern", foreign_key: :pattern_id

  validates :participant, :content, :effect, presence: true
  validates :effect, inclusion: { in: EFFECTS }

  scope :harmful, -> { where(effect: "harmful") }

  scope :no_pattern, -> { where(pattern_id: nil) }
end
