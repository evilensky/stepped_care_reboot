module ContentProviders
  # Provides a list of a Participant's unhelpful Thoughts.
  class UnhelpfulThoughtsListProvider < BitPlayer::ContentProvider
    data_class Thought
    show_nav_link
    view_type "index"

    def render_current(options)
      options.view_context.render(
        template: template,
        locals: {
          title: "You said you had the following unhelpful thoughts:",
          thoughts: options.participant.thoughts.harmful,
          postscript: "We’re going to ask you to challenge each thought:"
        }
      )
    end
  end
end
