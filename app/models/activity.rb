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
    where('activities.start_time is null and activities.end_time is null')
  end

  def self.during(start_time, end_time)
    where('start_time >= ? AND end_time <= ?', start_time, end_time)
  end

  private

  def create_activity_type
    if activity_type_title
      self.activity_type = participant.activity_types.create(title: activity_type_title)
    end
  end
end
