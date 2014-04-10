module ContentProviders
  # Displays all feelings the participant has had in the past
  class IndexPastFeelProvider < BitPlayer::ContentProvider
    data_class Emotion
    show_nav_link
    view_type "index"

    def render_current(options)
      options.view_context.render(
        template: template,
        locals: {
          emotions: options
            .view_context
            .current_participant
            .emotions(order: "created_at desc", limit: 8)
        }
      )
    end
  end
end
