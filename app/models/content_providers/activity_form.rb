class ContentProviders::ActivityForm < ContentProvider

  def render_current(options)
    options.view_context.render(
      template: 'activities/new',
      locals: {
        hours: [7,8,9,10,11,12,13,14,15,16,17], #this will be dynamic...
        activity: Activity.new,
        create_path: options.view_context.participant_data_path
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
