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
    if (context != tool.title) && tasks_to_complete?(tool)
      "<div class=\"fa-container\">#{fa_icon("asterisk")}</div>"
    elsif context == tool.title
      "<div class=\"fa-container\">#{fa_icon("caret-right")}</div>"
    else
      "<div class=\"fa-container\"></div>"
    end
  end

  def tasks_to_complete?(tool)
    content_modules = BitPlayer::ContentModule
      .where(bit_player_tool_id: tool.id)
    current_participant.tasks_to_complete(content_modules).count > 0
  end

  def module_not_assigned?(content_module, tasks, participant)
    if Task.joins(:bit_player_content_module)
        .where(tasks:
          { bit_player_content_module_id: content_module.id,
            group_id: participant.active_group.id }
        ).empty?
      true
    else
      false
    end
  end

  def content_module_link(content_module, tasks)
    if tasks.for_content_module(content_module).empty?
      title = content_module.title
      task_id = false
    else # Would we ever not want the first task status of a content module?
      title = "#{content_module.title} #{fa_icon("asterisk")}"
      task_id = tasks.for_content_module(content_module).first.id
    end
    link_to title.html_safe, navigator_location_path(
        module_id: content_module.id
      ), data: { task_status_id: task_id }, class: "content-module"
  end

  def unread_task?(ts)
    " <em class=\"pull-right\">unread</em>".html_safe unless ts.completed_at?
  end

  def todays_lesson(ts, response)
    membership = current_participant.membership
    response.html_safe if ts.release_day == membership.day_in_study
  end
end