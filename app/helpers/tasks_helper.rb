#used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper
  def assign_tool(group, tool_name)
    context_array = []
    group.tasks.each do |task|
      context_array << task.bit_player_content_module.context
    end
    if context_array
      context_array.include? tool_name
    else
      false
    end
  end
end

