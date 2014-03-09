class ContentProviders::ActivityIndexProvider < BitPlayer::ContentProvider
  data_class Activity
  show_nav_link
  view_type 'index'

  def render_current(options)
    options.view_context.render(
      template: template,
      locals: {
        activities: options.participant.recent_activities
      }
    )
  end
end
