class ContentProviders::ShowMessageProvider < BitPlayer::ContentProvider
  data_class Message
  hide_nav_link
  view_type 'show'

  def render_current(options)
    message = options.participant.received_messages.find_by_message_id(options.view_context.params[:message_id]) ||
      options.participant.messages.find(options.view_context.params[:message_id])
    message.try(:mark_read)

    options.view_context.render(
      template: template,
      locals: {
        message: message
      }
    )
  end
end
