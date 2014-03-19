module ContentProviders
  # Provides a view of current learning tools: videos and lessons
  class LearnLessonsIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      content_modules = BitPlayer::ContentModule

      options.view_context.render(
        template: 'learn/lessons_index',
        locals: { content_modules: content_modules.all }
      )
    end

    def show_nav_link?
      false
    end
  end
end