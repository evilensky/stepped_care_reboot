module ContentProviders
  # Provides a set of links to ContentModules in the current context.
  class ModuleIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: "content_modules/index",
        locals: {
          participant: options.participant,
          task_statuses: task_statuses(options)
        }
      )
    end

    def task_statuses(options)
      membership = options.participant.membership
      content_modules = BitPlayer::Tool.find_by_title(options.app_context)
        .content_modules
        .where.not(id: bit_player_content_module_id)
      membership.task_statuses
        .for_content_module_ids([content_modules.all.map(&:id)])
        .available(membership)
    end

    def show_nav_link?
      false
    end
  end
end