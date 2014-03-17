module ContentProviders
  # Provides a list of a Participant's helpful Thoughts.
  class HelpfulThoughtsIndexProvider < BitPlayer::ContentProvider
    data_class Thought
    show_nav_link
    view_type 'index'

    def render_current(options)
      options.view_context.render(
        template: template,
        locals: {
          thoughts: options.participant.thoughts.helpful
        }
      )
    end
  end
end
