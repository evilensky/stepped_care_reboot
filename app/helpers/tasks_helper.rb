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

  def content_module_link(content_module)
    if @current_participant.completed?(content_module)
      title = content_module.title
      task_status_id = false
    else
      title = "#{content_module.title} #{fa_icon("asterisk")}"
      task_status_id = @current_participant.task_status_for(content_module).id
    end
    link_to title.html_safe, navigator_location_path(
        module_id: content_module.id
      ), data: { task_status_id: task_status_id }, class: "content-module"
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