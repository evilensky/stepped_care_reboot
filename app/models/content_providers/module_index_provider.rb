module ContentProviders
  # Provides a set of links to ContentModules in the current context.
  class ModuleIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      content_modules = BitPlayer::Tool.find_by_title(options.app_context)
        .content_modules
        .where.not(id: bit_player_content_module_id)
      options.view_context.render(
        template: "content_modules/index",
        locals: {
          participant: options.participant,
          content_modules: content_modules
        }
      )
    end

    def show_nav_link?
      false
    end
  end
end