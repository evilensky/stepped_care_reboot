class ContentProviders::ActivityIndexProvider < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'activities/index', locals: {
        activities: options.participant.recent_activities
      }
    )
  end

  def exists?(position)
    false
  end

  def show_nav_link?
    true
  end
end
