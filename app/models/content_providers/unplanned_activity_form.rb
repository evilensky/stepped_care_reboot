class ContentProviders::UnplannedActivityForm < BitPlayer::ContentProvider
  def render_current(options)
    options.view_context.render(
      template: 'activities/unplanned_activity_form',
      locals: {
        activities: options.participant.activities.random.unplanned.first(4),
        update_path: options.view_context.participant_data_path
      }
    )
  end

  def data_attributes
    [
      :id, :activity, :start_time, :end_time, :activity_type_title,
      :predicted_pleasure_intensity, :predicted_accomplishment_intensity
    ]
  end

  def data_class_name
    'Activity'
  end

  def has_more_content?
    false
  end

  def show_nav_link?
    false
  end
end
