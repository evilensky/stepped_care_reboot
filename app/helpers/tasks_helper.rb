# Used to display asterisks if tasks and tools have been assigned to a group
# and to hide unassigned links
module TasksHelper
  def assign_tool(context, tool)
    if tool.title != "home"
      title = "#{tool.title} #{icon_div(context, tool)}".html_safe
      link_to title, navigator_context_path(context_name: tool.title)
    end
  end

  def icon_div(context, tool)
    if (context != tool.title) && @current_participant.incompleted?(tool)
      "<div class=\"fa-container\">#{fa_icon("asterisk")}</div>"
    elsif context == tool.title
      "<div class=\"fa-container\">#{fa_icon("caret-right")}</div>"
    else
      "<div class=\"fa-container\"></div>"
    end
  end

  def task_status_link(task_status)
    if task_status.is_completed?
      title = task_status.title
    else
      title = "#{task_status.title} #{fa_icon("asterisk")}"
    end
    link_to title.html_safe, navigator_location_path(
        module_id: task_status.bit_player_content_module_id
      ), class: "task-status", id: "task-status-#{task_status.id}", :"data-task-status-id" => "#{task_status.id}"
  end

  def unread_task?(task_status)
    unless task_status.completed_at?
      " <em class=\"pull-right\">unread</em>".html_safe
    end
  end

  def todays_lesson(task_status, response)
    membership = current_participant.membership
    response.html_safe if task_status.release_day == membership.day_in_study
  end
end