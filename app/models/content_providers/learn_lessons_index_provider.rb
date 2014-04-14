module ContentProviders
  # Provides a view of current learning tools: videos and lessons
  class LearnLessonsIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      assign_variables(options)
      options.view_context.render(
        template: "learn/lessons_index",
        locals: {
          all_tasks: @all_tasks,
          all_available_tasks: @all_available_tasks
        }
      )
    end

    def all_tasks
      @participant.learning_tasks(@content_modules)
    end

    def all_available_tasks
      all_tasks.available_for_learning(@participant.membership)
    end

    def assign_variables(options)
      @participant = options.participant
      @content_modules = content_modules(options)
      @all_tasks = all_tasks
      @all_available_tasks = all_available_tasks
    end

    def content_modules(options)
      BitPlayer::ContentModule.joins(:tool)
        .where("bit_player_tools.title = ?", options.app_context)
        .where.not(id: bit_player_content_module_id)
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
