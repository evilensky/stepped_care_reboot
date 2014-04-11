module ContentProviders
  # Provides a list of a Participant"s helpful Thoughts.
  class HelpfulThoughtsIndexProvider < BitPlayer::ContentProvider
    data_class Thought
    show_nav_link
    view_type "index"

    def render_current(options)
      options.view_context.render(
        template: template,
        locals: {
          title: "Helpful Thoughts",
          introduction: introduction,
          thoughts: options.participant.thoughts.helpful
        }
      )
    end

    private

    def introduction
      "<p>Last time you were here...<br>" \
        "You noted that you’ve been thikning some things that are helpful." \
        "<p>Being aware of these thoughts can be helpful." \
        "<p>In case you’ve forgotten...".html_safe
    end
  end
end
