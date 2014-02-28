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
  
  scope :pleasurable, -> do
    where('activities.actual_pleasure_intensity >= ?', PLEASURABLE_CUTOFF)
  end

  scope :accomplished, -> do
    where('activities.actual_accomplishment_intensity >= ?', ACCOMPLISHED_CUTOFF)
  end

  scope :random, -> do
    order("RANDOM()")
  end

  scope :in_the_past, -> do
    where('activities.end_time < ?', Time.now)
  end

  scope :unplanned, -> do
    where(start_time: nil, end_time: nil)
  end

  scope :incomplete, -> do
    where(is_complete: false)
  end

  def self.during(start_time, end_time)
    where('start_time >= ? AND end_time <= ?', start_time, end_time)
  end

  def actual_pleasure_value
    Values::Pleasure.from_intensity(actual_pleasure_intensity)
  end

  def actual_accomplishment_value
    Values::Accomplishment.from_intensity(actual_accomplishment_intensity)
  end

  private

  def create_activity_type
    if activity_type_title && participant.activity_types.create(title: activity_type_title)
      self.activity_type = participant.activity_types.find_by_title(activity_type_title)
    end
  end
end
