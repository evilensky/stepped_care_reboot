class ContentProviders::AwakePeriodForm < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'awake_periods/new', locals: {
        awake_period: AwakePeriod.new,
        create_path: options.view_context.participant_data_path
      }
    )
  end

  def has_more_content?
    false
  end

  def data_class_name
    'AwakePeriod'
  end

  def data_attributes
    [:start_time, :end_time]
  end

  def show_nav_link?
    false
  end
end
