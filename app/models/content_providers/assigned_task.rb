class ContentProviders::AssignedTask
  def render_current(context)
    context.render template: 'assigned_tasks/show'
  end

  def has_more_content?
    false
  end

  def path
    'assigned_task'
  end
end
