module Participants
  # Updates the completion of assigned tasks for a participant
  class TaskStatusController < ApplicationController
    before_action :authenticate_participant!

    def update
      @task_status = TaskStatus.find(params[:id])
      if @task_status.is_completed? || @task_status.update(completed_at: DateTime.new)
        render nothing: true, status: 200
      else
        render nothing: true, status: 500
      end
    end
  end
end