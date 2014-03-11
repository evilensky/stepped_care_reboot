class ContentProviders::EmotionEnergyIntensityFormProvider < BitPlayer::ContentProvider
  def render_current(options)
    emotion = options.view_context.current_participant.emotions.last

    case emotion.rating
    when -5..-4
      emotion_types = [["Depressed", -2], ["Sad", -1], ["Stressed", 2], ["Upset", 1]]
    when -3..-2
      emotion_types = [["Bored", -3], ["Fatigued", -4], ["Nervous", 3], ["Tense", 4]]
    when -1..1
      emotion_types = [["Alert", 4], ["Calm", -4], ["Fatigued", -4], ["Tense", 4]]
    when 2..3
      emotion_types = [["Alert", 4], ["Calm", -4], ["Excited", 3], ["Relaxed", -3]]
    when 4..5
      emotion_types = [["Contented", -1], ["Elated", 2], ["Happy", 1], ["Serene", -2]]
    else
      emotion_types = []
    end

    options.view_context.render(
      template: 'emotions/energy_intensity',
      locals: {
        emotion: emotion,
        emotion_types: emotion_types,
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
