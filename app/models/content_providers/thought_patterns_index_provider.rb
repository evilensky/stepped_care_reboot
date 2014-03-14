module ContentProviders
  class ThoughtPatternsIndexProvider < BitPlayer::ContentProvider
    data_class ThoughtPattern
    hide_nav_link
    view_type 'index'

    def render_current(options)
      options.view_context.render(
        template: template,
        locals: {
          thought_patterns: ThoughtPattern.all
        }
      )
    end
  end
end
