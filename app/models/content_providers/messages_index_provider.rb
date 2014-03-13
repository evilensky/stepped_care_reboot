class ContentProviders::MessagesIndexProvider < BitPlayer::ContentProvider
  def render_current(options)
    compose_path = options.view_context.navigator_location_path(
      context: 'messages',
      module_id: content_module.id,
      provider_id: content_module.content_providers.find_by_type('ContentProviders::NewMessageFormProvider').id,
      content_position: 1
    )

    show_path = lambda do |params|
      options.view_context.navigator_location_path({
        context: 'messages',
        module_id: content_module.id,
        provider_id: content_module.content_providers.find_by_type('ContentProviders::ShowMessageProvider').id,
        content_position: 1
      }.merge(params))
    end

    options.view_context.render(
      template: 'messages/index',
      locals: {
        sent_messages: options.participant.sent_messages.order(:sent_at),
        received_messages: options.participant.received_messages.order('messages.sent_at'),
        compose_path: compose_path,
        show_path: show_path
      }
    )
  end

  def show_nav_link?
    false
  end
end
