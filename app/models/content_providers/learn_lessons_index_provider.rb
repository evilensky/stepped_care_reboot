module ContentProviders
  # Provides a view of current learning tools: videos and lessons
  class LearnLessonsIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      content_modules = BitPlayer::ContentModule.joins(:tool)
        .where("bit_player_tools.title = ?", options.app_context)
        .where.not(id: bit_player_content_module_id)
      task_statuses = options.participant.learning_tasks(content_modules)
      options.view_context.render(
        template: "learn/lessons_index",
        locals: { task_statuses: task_statuses }
      )
    end

    def days_into_intervention(membership)
      time_diff = Time.now - membership.start_date
      days = time_diff / (3600 * 24)
      days.ceil
    end

    def show_nav_link?
      false
    end
  end
end
