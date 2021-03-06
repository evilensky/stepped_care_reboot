module ContentProviders
  # Allows user to submit a mood from the past 24 hours.
  class NewPastFeelProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: "feel/new_past_mood",
        locals: {
          mood: options.view_context.current_participant.moods.build,
          create_path: options.view_context.participant_data_path
        }
      )
    end

    def data_class_name
      "Mood"
    end

    def data_attributes
      [:rating]
    end

    def show_nav_link?
      false
    end
  end
end
