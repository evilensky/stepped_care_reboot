class ContentProviders::ActivityForm < ContentProvider

  require "#{Rails.root}/lib/time"  
  
  def render_current(view_context, position)
    most_recent_awake_period = AwakePeriod.last
    start_time = most_recent_awake_period.start_time
    end_time = most_recent_awake_period.end_time
    timestamps = []
    (start_time.to_i .. (end_time.to_i - 1.hour)).step(1.hour) do |timestamp|
      timestamps << timestamp
    end
    view_context.render(
      template: 'activity/new',
      locals: {
        timestamps: timestamps,
        activity: Activity.new,
        create_path: view_context.participant_data_path
      }
    )
  end

  def has_more_content?
    false
  end

  def data_class_name
    'Activity'
  end

  # def data_attributes
  #   [:start_time, :end_time]
  # end

  def show_nav_link?
    false
  end

end
