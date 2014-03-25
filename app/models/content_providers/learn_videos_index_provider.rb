module ContentProviders
  # Displays all feelings the participant has had in the past
  class LearnVideosIndexProvider < BitPlayer::ContentProvider
    def render_current(options)
      options.view_context.render(
        template: "learn/videos_index",
        locals: { videos: BitPlayer::VideoSlide.all }
      )
    end

    def show_nav_link?
      false
    end
  end
end