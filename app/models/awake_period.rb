class AwakePeriod < ActiveRecord::Base
  belongs_to :participant

  validates_presence_of :participant, :start_time, :end_time
  validate :end_time_after_start_time
  validate :awake_periods_cannot_overlap

  def awake_periods_cannot_overlap
    if AwakePeriod.where('start_time < ? and end_time > ?', end_time, start_time).limit(1).count == 1
      errors.add(:base, "This awake period already exists")
    end
  end

  def end_time_after_start_time
    if start_time && end_time && end_time <= start_time
      errors.add :end_time, 'Must be after the start time'
    end
  end
end
