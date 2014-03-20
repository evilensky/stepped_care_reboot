module ContentProviders
  # Provides a view of current learning tools: videos and lessons
  class LearnLessonsIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      membership = options.participant.memberships.first
      group = membership.group if membership
      slideshows = group ? group.bit_player_slideshows : []
      options.view_context.render(
        template: 'learn/lessons_index',
        locals: { content_modules: slideshows }
      )
    end

    def show_nav_link?
      false
    end
  end
end