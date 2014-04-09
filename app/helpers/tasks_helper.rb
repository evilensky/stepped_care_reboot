# Used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper
  def assign_tool(context, tool)
    title = tool.title
    if context == title
      text = tool.title + " " + fa_icon("caret-right")
    elsif (context != tool.title) && tasks_to_complete?(tool)
      text = fa_icon("asterisk") + " " + title
    else
      text = title
    end
    link_to text.html_safe, navigator_context_path(context_name: title)
  end

  def tasks_to_complete?(tool)
    content_modules = BitPlayer::ContentModule
      .where(bit_player_tool_id: tool.id)
    current_participant.tasks_to_complete(content_modules).count > 0
  end

  def content_module_link(content_module, tasks)
    if tasks.for_content_module(content_module).empty?
      title = content_module.title
      task_id = false
    else # Can there be more than one task status for a content module?
      title = fa_icon("asterisk") + " " + content_module.title
      task_id = tasks.for_content_module(content_module).first.id
    end
    link_to title.html_safe, navigator_location_path(
        module_id: content_module.id
      ), data: { task_status_id: task_id }, class: "content-module"
  end
end