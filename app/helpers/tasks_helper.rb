#used to display asterisks if tasks and tools have been assigned to a group
module TasksHelper
  def assign_module(user, title)
    module_array = []
    Task.to_be_completed_by_participant(user).each do |task|
      module_array << task.bit_player_content_module.title
    end
    module_array.include? title
  end

  def assign_tool(user, tool_name)
    context_array = []
    Task.to_be_completed_by_participant(user).each do |task|
      context_array << task.bit_player_content_module.context
    end
    context_array.include? tool_name
  end

  def get_task_id(user, title)
    content_module = BitPlayer::ContentModule.find_by_title(title)
    task = Task.for_participant(user).find_by_bit_player_content_module_id(content_module.id)
    id = task ? task.id : false
  end
end