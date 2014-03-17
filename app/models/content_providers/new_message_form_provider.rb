module ContentProviders
  # Provides a form for a Participant to compose a new Message.
  class NewMessageFormProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: "messages/new",
        locals: {
          message: message(options.participant),
          create_path: options.view_context.participant_data_path
        }
      )
    end

    def data_class_name
      "Message"
    end

    def data_attributes
      [:recipient_type, :recipient_id, :subject, :body]
    end

    def show_nav_link?
      false
    end

    private

    def message(participant)
      coach = participant.coach

      participant.sent_messages.build(
        recipient_id: coach.id,
        recipient_type: coach.class.to_s
      )
    end
  end
end
