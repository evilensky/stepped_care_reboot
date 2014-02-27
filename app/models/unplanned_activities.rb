class UnplannedActivities
  Errors = Struct.new(:full_messages)

  def initialize(participant)
    @participant = participant
    @activities = []
  end

  def build(attributes)
    activity_type_ids = attributes[:activity_type_ids] || []
    activity_type_ids.each do |activity_type_id|
      @activities << @participant.activities.build(activity_type_id: activity_type_id)
    end

    self
  end

  def save
    begin
      Activity.transaction do
        @activities.map(&:save!)
      end

      true
    rescue ActiveRecord::StatementInvalid => err
      @errors = Errors.new(err)

      false
    end
  end

  def errors
    @errors
  end
end
