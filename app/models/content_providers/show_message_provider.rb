class ContentProviders::ShowMessageProvider < BitPlayer::ContentProvider
  def render_current(options)
    message = options.participant.received_messages.find_by_message_id(options.view_context.params[:message_id]) ||
      options.participant.messages.find(options.view_context.params[:message_id])
    message.try(:mark_read)

    options.view_context.render(
      template: 'messages/show',
      locals: {
        message: message
      }
    )
  end

  def show_nav_link?
    false
  end
end
