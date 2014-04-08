module ContentProviders
  # Provides a set of links to ContentModules in the current context.
  class ModuleIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      participant = options.participant
      content = BitPlayer::ContentModule
        .where(context: options.app_context)
        .where.not(id: bit_player_content_module_id)
      options.view_context.render(
        template: "content_modules/index",
        locals: {
          content_modules: content,
          tasks_to_be_completed: TaskStatus.to_complete(participant, content) }
      )
    end

    def show_nav_link?
      false
    end
  end
end