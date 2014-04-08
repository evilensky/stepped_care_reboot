# Used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper

  def assign_tool(context, section)
    if context == section.slug
      text = section.label + " " + fa_icon('caret-right')
    elsif context != section.slug and TaskStatus.to_complete(current_participant, BitPlayer::ContentModule.where(context: section.slug)).count > 0
      text = fa_icon('asterisk') + " " + section.label
    else
      text = section.label
    end
    link_to text.html_safe, navigator_context_path(context_name: section.slug)
  end

  def content_module_link(content_module, tasks_to_be_completed)
    tasks_for_content_module = tasks_to_be_completed.for_content_module(content_module)
    if tasks_for_content_module.empty?
      title = content_module.title
      task_id = false
    else
      title = fa_icon('asterisk') + " " + content_module.title
      task_id = tasks_for_content_module.first.id
    end
    link_to title.html_safe, navigator_location_path(module_id: content_module.id), data: { task_status_id: task_id }, class: "module"
  end
end