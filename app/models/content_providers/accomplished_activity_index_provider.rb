class ContentProviders::AccomplishedActivityIndexProvider < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'activities/accomplished_index', locals: {
        activities: options.participant.recent_accomplished_activities
      }
    )
  end

  def exists?(position)
    false
  end

  def show_nav_link?
    false
  end
end