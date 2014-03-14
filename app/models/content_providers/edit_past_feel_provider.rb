class ContentProviders::EditPastFeelProvider < BitPlayer::ContentProvider
  
  def render_current(options)
    mood = options.view_context.current_participant.moods.last

    if mood.rating < 0    
      mood_related_emotions = ["Anger", "Exasperation", "Rage", "Disgust",
        "Envy", "Torment", "Sadness", "Sadness", "Disappointment", "Shame",
        "Neglect", "Fear", "Nervousness"]
      valence = -1
    elsif mood.rating == 0
      mood_related_emotions = ["Longing", "Lust/Sexual desire", "Surprise",
        "Sympathy"]
      valence = 0
    else
      mood_related_emotions = ["Contentment", "Enthrallment", "Love", "Joy",
        "Optimism", "Pride", "Relief", "Zest"]
      valence = 1
    end

    emotions = []
    mood_related_emotions.each do |emotion|
      emotions << options.view_context.current_participant.emotions.build({
        valence: valence,
        name: emotion,
        rating: mood.rating
      })
    end

    options.view_context.render(
      template: 'mood/edit',
      locals: {
        emotions: emotions,
        count: emotions.count,
        update_path: options.view_context.participant_data_path
      }
    )
  end

  def data_class_name
    'Emotion'
  end

  def data_attributes
    [:valence, :intensity, :rating]
  end

  def show_nav_link?
    false
  end

end
