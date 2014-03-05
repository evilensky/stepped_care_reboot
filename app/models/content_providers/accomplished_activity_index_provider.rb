class ContentProviders::AccomplishedActivityIndexProvider < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'activities/accomplished_index', locals: {
        activities: options.participant.recent_accomplished_activities
      }
    )
  end

  def show_nav_link?
    true
  end
end
