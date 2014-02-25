class Activity < ActiveRecord::Base
  PLEASURABLE_CUTOFF = 6
  ACCOMPLISHED_CUTOFF = 6

  belongs_to :activity_type
  belongs_to :participant

  validates_presence_of :activity_type, :participant, :start_time, :end_time
  validates_inclusion_of :is_complete, in: [true, false]

  delegate :title, to: :activity_type, prefix: false, allow_nil: true

  scope :pleasurable, -> do
    where('activities.actual_pleasure_intensity >= ?', PLEASURABLE_CUTOFF)
  end

  scope :accomplished, -> do
    where('activities.actual_accomplishment_intensity >= ?', ACCOMPLISHED_CUTOFF)
  end

  def self.during(start_time, end_time)
    where('start_time >= ? AND end_time <= ?', start_time, end_time)
  end
end
