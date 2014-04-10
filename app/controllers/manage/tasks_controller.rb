module Manage
  # User manages task creation, destruction, and assignment for groups
  class TasksController < ApplicationController
    before_action :authenticate_user!, only: [:create, :destory]

    def create
      if task.save
        redirect_to manage_tasks_group_path(group), notice: "Task assigned."
      else
        errors = task.errors.full_messages.join(", ")
        flash[:alert] = "Unable to assign task: #{ errors }"
        redirect_to manage_tasks_group_path(task.group)
      end
    end

    def destroy
      deleted_group = task.group
      if task.destroy
        flash.now[:success] = "Task unassigned from group."
        redirect_to manage_tasks_group_path(deleted_group)
      else
        errors = task.errors.full_messages.join(", ")
        flash[:error] = "Unable to delete task from group: #{ errors }"
        redirect_to manage_tasks_group_path(deleted_group)
      end
    end

    private

    def _params
      params.require(:task)
        .permit(
          :created_at,
          :group_id,
          :bit_player_content_module_id,
          :release_day
        )
    end

    def task
      @task ||=
      if params[:id]
        Task.find(params[:id])
      else
        current_user.tasks.build(_params)
      end
    end
    helper_method :task

    def group
      @group ||= task.group
    end
    helper_method :group
  end
end