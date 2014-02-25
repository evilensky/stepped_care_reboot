class ContentProviders::ActivityIndexProvider < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'activities/index', locals: {
        activities: options.participant.recent_activities
      }
    )
  end

  def has_more_content?
    false
  end

  def show_nav_link?
    false
  end
end
