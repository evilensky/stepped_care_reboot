class ContentProviders::RandomActivityChecklist < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'activities/random_activity_checklist', locals: {
        past_activities: options.participant.activities.random.first(5),
        create_path: options.view_context.participant_data_path 
      }
    )
  end

  def data_attributes
    [:activity_type_ids]
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