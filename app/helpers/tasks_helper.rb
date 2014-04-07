# Used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper
  def assign_tool(user, tool_name)
    # context_array = []
    # Task.to_be_completed_by_participant(user).each do |task|
    #   context_array << task.bit_player_content_module.context
    # end
    # context_array.include? tool_name
  end

  def content_module_link(content_module, tasks_to_be_completed)
    tasks_for_content_module = tasks_to_be_completed.for_content_module(content_module)
    unless tasks_for_content_module.empty?
      title = "#{fa_icon('asterisk')} #{content_module.title}".html_safe
      task_id = tasks_for_content_module.first.id
    else
      title = content_module.title
      task_id = false
    end
    link_to title, navigator_location_path(module_id: content_module.id), data: { taskstatusid: task_id }, class: "module"
  end
end