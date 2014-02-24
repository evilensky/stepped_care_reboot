class Activity < ActiveRecord::Base
  belongs_to :activity_type
  belongs_to :participant

  validates_presence_of :activity_type, :participant, :start_time, :end_time
  validates_inclusion_of :is_complete, in: [true, false]
end