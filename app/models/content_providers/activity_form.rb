class ContentProviders::ActivityForm < ContentProvider

  def render_current(view_context)
    view_context.render(template: 'activity/new', locals: {
        hours: [1,2,3,4],
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
