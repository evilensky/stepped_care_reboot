module ContentProviders
  # Displays all feelings the participant has had in the past
  class IndexPastFeelProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: 'feel/index',
        locals: {
          emotions: options
            .view_context
            .current_participant
            .emotions
            .all(order: 'created_at desc', limit: 8)
        }
      )
    end

    def data_class_name
      'Emotion'
    end

    def show_nav_link?
      false
    end
  end
end
