class AwakePeriod < ActiveRecord::Base
  belongs_to :participant

  validates_presence_of :participant, :start_time, :end_time
  validate :end_time_after_start_time

  def end_time_after_start_time
    if start_time && end_time && end_time <= start_time
      errors.add :end_time, 'Must be after the start time'
    end
  end
end
