class ContentProviders::NewEmotionFormProvider < BitPlayer::ContentProvider
  def render_current(options)
    options.view_context.render(
      template: 'emotions/new',
      locals: {
        emotion: options.view_context.current_participant.emotions.build,
        create_path: options.view_context.participant_data_path
      }
    )
  end

  def data_class_name
    'Emotion'
  end

  def data_attributes
    [:rating]
  end

  def show_nav_link?
    false
  end

end
