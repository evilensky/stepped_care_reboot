module ContentProviders
  # Provides a view of a sent or received Message.
  class ShowMessageProvider < BitPlayer::ContentProvider
    data_class Message
    hide_nav_link
    view_type 'show'

    def render_current(options)
      received_message = options.participant.received_messages
        .find_by_message_id(options.view_context.params[:message_id])
      sent_message = options.participant.messages
        .find(options.view_context.params[:message_id])
      message = received_message || sent_message
      message.try(:mark_read)

      options.view_context.render(
        template: template,
        locals: { message: message }
      )
    end
  end
end
