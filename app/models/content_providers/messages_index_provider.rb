module ContentProviders
  class MessagesIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: "messages/index",
        locals: {
          sent_messages: options.participant.sent_messages.order(:sent_at),
          received_messages: received_messages(options.participant),
          compose_path: compose_path(options.view_context),
          show_path: show_path(options.view_context)
        }
      )
    end

    def show_nav_link?
      false
    end

    private

    def compose_path(view_context)
      provider_id = content_module.content_providers
        .find_by_type("ContentProviders::NewMessageFormProvider").id

      view_context.navigator_location_path(
        context: "messages",
        module_id: content_module.id,
        provider_id: provider_id,
        content_position: 1
      )
    end

    def show_path(view_context)
      provider_id = content_module.content_providers
        .find_by_type("ContentProviders::ShowMessageProvider").id

      lambda do |params|
        view_context.navigator_location_path({
          context: "messages",
          module_id: content_module.id,
          provider_id: provider_id,
          content_position: 1
        }.merge(params))
      end
    end

    def received_messages(participant)
      participant.received_messages.order("messages.sent_at")
    end
  end
end
