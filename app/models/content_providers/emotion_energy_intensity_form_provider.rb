class ContentProviders::EmotionEnergyIntensityFormProvider < BitPlayer::ContentProvider
  def render_current(options)
    emotion = options.view_context.current_participant.emotions.last

    case emotion.rating
    when 1..2
      emotion_types = [["Alert", 4], ["Excited", 3], ["Elated", 2], ["Happy", 1]]
    when 3..5
      emotion_types = [["Contented", -1], ["Serene", -2], ["Relaxed", -3], ["Calm", -4]]
    when 5
      emotion_types = [["Relaxed", -3], ["Calm", -4], ["Tense", 4], ["Nervous", 3]]
    when 6..8
      emotion_types = [["Tense", 4], ["Nervous", 3], ["Stressed", 2], ["Upset", 1]]
    when 9..10
      emotion_types = [["Sad", -1], ["Depressed", -2], ["Bored", -3], ["Fatigued", -4]]
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
