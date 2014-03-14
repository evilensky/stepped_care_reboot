module ContentProviders
  class PleasurableActivityIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: 'activities/pleasurable_index',
        locals: {
          activities: options.participant.recent_pleasurable_activities
        }
      )
    end

    def show_nav_link?
      true
    end
  end
end
