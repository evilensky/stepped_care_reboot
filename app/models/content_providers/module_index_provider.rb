module ContentProviders
  # Provides a set of links to ContentModules in the current context.
  class ModuleIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      content_modules = BitPlayer::ContentModule.joins(:tool)
        .where("bit_player_tools.title = ?", options.app_context)
        .where.not(id: bit_player_content_module_id)
      options.view_context.render(
        template: "content_modules/index",
        locals: {
          content_modules: content_modules,
          tasks: TaskStatus.to_complete(options.participant, content_modules)
        }
      )
    end

    def show_nav_link?
      false
    end
  end
end