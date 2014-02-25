class ContentProviders::AssignedTask
  def render_current(options)
    options.view_context.render template: 'assigned_tasks/show'
  end

  def exists?(position)
    false
  end

  def path
    'assigned_task'
  end
end
