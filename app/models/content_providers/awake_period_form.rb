class ContentProviders::AwakePeriodForm
  def render_current(view_context)
    view_context.render(template: 'awake_periods/new', locals: {
        awake_period: AwakePeriod.new,
        create_path: view_context.participant_data_path
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
end
