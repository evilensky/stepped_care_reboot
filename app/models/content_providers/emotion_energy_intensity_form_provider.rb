class ContentProviders::EmotionEnergyIntensityFormProvider < BitPlayer::ContentProvider
  def render_current(options)
    options.view_context.render(
      template: 'emotions/energy_intensity',
      locals: {
        emotion: options.view_context.current_participant.emotions.last,
        emotion_types: [["Sad", 1], ["Happy", 2]], #expand on this...
        update_path: options.view_context.participant_data_path
      }
    )
  end

  def data_class_name
    'Emotion'
  end

  def data_attributes
    [:activation_level, :intensity, :rating]
  end

  def show_nav_link?
    false
  end

end
