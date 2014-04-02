#used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper
  def assign_tool(group, tool_name)
    context_array = []
    group.tasks.each do |task|
      context_array << task.bit_player_content_module.context unless task.is_complete
    end
    if context_array
      context_array.include? tool_name
    else
      false
    end
  end

  def assign_module(group, title)
    module_array = []
    group.tasks.each do |task|
      module_array << task.bit_player_content_module.title unless task.is_complete
    end
    if module_array
      module_array.include? title
    else
      false
    end
  end

  def get_task_id(group, title)
    content_module = BitPlayer::ContentModule.where(title: title).first
    Task.where(group_id: group.id, bit_player_content_module_id: content_module.id).first.id rescue ''
  end
end

