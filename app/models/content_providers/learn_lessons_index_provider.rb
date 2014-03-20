module ContentProviders
  # Provides a view of current learning tools: videos and lessons
  class LearnLessonsIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      # right now there is only one membership for a participant
      membership = options.participant.memberships.first

      joins = GroupSlideshowJoin.where(
        "group_id = ? AND release_day <= ?",
        membership.group.id, days_into_intervention(membership)
      )

      options.view_context.render(
        template: 'learn/lessons_index',
        locals: { group_slideshow_joins: joins }
      )
    end

    def days_into_intervention(membership)
      TimeDifference.between(membership.start_date, Time.now)
      .in_days.ceil
    end

    def show_nav_link?
      false
    end
  end
end