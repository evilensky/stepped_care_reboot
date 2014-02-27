class ContentProviders::AssignedTask < ContentProvider
  def render_current(options)
    options.view_context.render(
      template: 'assigned_tasks/show',
      assigned_task: nil
    )
  end

  def exists?(position)
    false
  end

  def show_nav_link?
    true
  end
end
