class Activity < ActiveRecord::Base
  
  attr_accessor :activity_type_title

  PLEASURABLE_CUTOFF = 6

  belongs_to :activity_type
  belongs_to :participant

  validates_presence_of :activity_type, :participant, :start_time, :end_time
  validates_inclusion_of :is_complete, in: [true, false]

  delegate :title, to: :activity_type, prefix: false

  before_validation :create_activity_type
  
  scope :pleasurable, -> do
    where('activities.actual_pleasure_intensity >= ?', PLEASURABLE_CUTOFF)
  end

  def self.during(start_time, end_time)
    where('start_time >= ? AND end_time <= ?', start_time, end_time)
  end

  private

  def create_activity_type
  	self.activity_type = participant.activity_types.create(title: self.activity_type_title)
  end

end
