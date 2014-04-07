module Participants
  class TaskStatusController < ApplicationController
    before_action :authenticate_participant!

    def update
      @task_status = TaskStatus.find(params[:id])
      if @task_status.update(completed_at: DateTime.new)
        render nothing: true, status: 200
      else
        render nothing: true, status: 500
      end
    end

  end
end