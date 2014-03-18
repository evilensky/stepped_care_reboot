class ContentProviders::IndexPastFeelProvider < BitPlayer::ContentProvider
  
  def render_current(options)
    options.view_context.render(
      template: 'feel/index',
      locals: {
        emotions: options.view_context.current_participant.emotions
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
