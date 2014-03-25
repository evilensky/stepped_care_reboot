module ContentProviders
  # Provides a view of a Participant"s AssignedTask.
  class AssignedTaskProvider < BitPlayer::ContentProvider
    data_class AssignedTask
    show_nav_link
    view_type "show"

    def render_current(options)
      options.view_context.render(
        template: template,
        assigned_task: nil
      )
    end
  end
end
