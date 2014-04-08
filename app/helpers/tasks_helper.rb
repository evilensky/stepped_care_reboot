# Used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper
  def assign_tool(context, section)
    if context == section.slug
      text = section.label + " " + fa_icon("caret-right")
    elsif (context != section.slug) && tasks_to_complete!(section)
      text = fa_icon("asterisk") + " " + section.label
    else
      text = section.label
    end
    link_to text.html_safe, navigator_context_path(context_name: section.slug)
  end

  def tasks_to_complete!(section)
    content_modules = BitPlayer::ContentModule.where(context: section.slug)
    TaskStatus.to_complete(current_participant, content_modules).count > 0
  end

  def content_module_link(content_module, tasks_to_be_completed)
    tasks = tasks_to_be_completed.for_content_module(content_module)
    if tasks.empty?
      title = content_module.title
      task_id = false
    else
      title = fa_icon("asterisk") + " " + content_module.title
      task_id = tasks.first.id
    end
    link_to title.html_safe, navigator_location_path(
        module_id: content_module.id
      ), data: { task_status_id: task_id }, class: "module"
  end
end