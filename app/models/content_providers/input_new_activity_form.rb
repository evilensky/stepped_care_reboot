class ContentProviders::InputNewActivityForm < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'activities/input_new_activity_form', locals: {
        create_path: options.view_context.participant_data_path 
      }
    )
  end

  def data_attributes
    [:activity_type_title]
  end

  def data_class_name
    'UnplannedActivity'
  end

  def exists?(position)
    false
  end

  def show_nav_link?
    false
  end
end