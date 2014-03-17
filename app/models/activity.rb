# Represents a real-world activity of a participant.
class Activity < ActiveRecord::Base
  attr_accessor :activity_type_title

  PLEASURABLE_CUTOFF = 6
  ACCOMPLISHED_CUTOFF = 6

  belongs_to :activity_type
  belongs_to :participant

  validates_presence_of :activity_type, :participant
  validates_inclusion_of :is_complete, in: [true, false]

  delegate :title, to: :activity_type, prefix: false, allow_nil: true

  before_validation :create_activity_type

  scope :pleasurable, lambda {
    where("activities.actual_pleasure_intensity >= ?", PLEASURABLE_CUTOFF)
  }

  scope :accomplished, lambda {
    where(
      "activities.actual_accomplishment_intensity >= ?",
      ACCOMPLISHED_CUTOFF
    )
  }

  scope :random, lambda {
    order("RANDOM()")
  }

  scope :in_the_past, lambda {
    where("activities.end_time < ?", Time.now)
  }

  scope :unplanned, lambda {
    where(start_time: nil, end_time: nil)
  }

  scope :incomplete, lambda {
    where(is_complete: false)
  }

  def self.during(start_time, end_time)
    where("start_time >= ? AND end_time <= ?", start_time, end_time)
  end

  def actual_pleasure_value
    Values::Pleasure.from_intensity(actual_pleasure_intensity)
  end

  def actual_accomplishment_value
    Values::Accomplishment.from_intensity(actual_accomplishment_intensity)
  end

  private

  def create_activity_type
    if activity_type_title
      activity_types = participant.activity_types

      if activity_types.create(title: activity_type_title)
        self.activity_type = activity_types.find_by_title(activity_type_title)
      end
    end
  end
end
