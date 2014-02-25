class ContentProviders::ActivityForm < ContentProvider

  def render_current(options)
    most_recent_awake_period = AwakePeriod.last
    start_time = most_recent_awake_period.start_time
    end_time = most_recent_awake_period.end_time
    timestamps = []
    (start_time.to_i .. (end_time.to_i - 1.hour)).step(1.hour) do |timestamp|
      timestamps << timestamp
    end
    options.view_context.render(
      template: 'activities/new',
      locals: {
        timestamps: timestamps,
        activity: Activity.new,
        create_path: options.view_context.participant_data_path
      }
    )
  end

  def exists?(position)
    false
  end

  def data_class_name
    'Activity'
  end

  def show_nav_link?
    false
  end

end
