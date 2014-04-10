module ContentProviders
  # This view displays emotions related to
  # the mood selected in the previous page
  class EditPastFeelProvider < BitPlayer::ContentProvider
    def render_current(options)
      participant_emotions_array = determine_participant_emotions(options)

      options.view_context.render(
        template: "feel/edit_emotion",
        locals: {
          emotions: participant_emotions_array,
          count: participant_emotions_array.count,
          update_path: options.view_context.participant_data_path
        }
      )
    end

    def determine_participant_emotions(options)
      participant = options.view_context.current_participant
      mood = participant.moods.last if participant
      valence_value = valence(mood) if mood
      # This could be a method on the participant...
      participant_emotions_array(participant, mood, valence_value)
    end

    def data_class_name
      "Emotion"
    end

    def data_attributes
      [:valence, :intensity, :rating, :name]
    end

    def participant_emotions_array(participant, mood, valence)
      mood_related_emotions(mood).map do |emotion|
        participant.emotions.build(
          valence: valence,
          name: emotion,
          rating: mood.rating
        )
      end
    end

    def show_nav_link?
      false
    end

    private

    def mood_related_emotions(mood)
      if mood.rating < 5
        ["Anger", "Exasperation", "Rage", "Disgust",
         "Envy", "Torment", "Sadness", "Sadness", "Neglect",
         "Disappointment", "Shame", "Fear", "Nervousness"]
      elsif mood.rating == 5
        ["Longing", "Surprise", "Sympathy"]
      else
        ["Contentment", "Enthrallment", "Joy",
         "Optimism", "Pride", "Relief"]
      end
    end

    def valence(mood)
      if mood.rating < 5
        -1
      elsif mood.rating == 5
        0
      else
        1
      end
    end
  end
end
