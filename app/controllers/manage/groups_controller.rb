module Manage
  # Users can view groups to CRUD and assign slideshows
  class GroupsController < ApplicationController
    before_action :authenticate_user!
    layout "manage_group"

    def index
      respond_to do |format|
        format.html { render layout: "basic" }
      end
    end

    def edit_slideshows
    end

    def edit_tasks
    end

    private

    def _task_params
      if params[:task]
        params.require(:task)
          .permit(:bit_player_content_module_id, :group_id)
      end
    end

    def tasks
      group.tasks
    end
    helper_method :tasks

    def slideshows
      BitPlayer::Slideshow.all
    end
    helper_method :slideshows

    def content_modules
      @content_modules ||= BitPlayer::ContentModule.all
    end
    helper_method :content_modules

    def groups
      Group.all
    end
    helper_method :groups

    def group
      @group ||=
        if params[:id]
          Group.find(params[:id])
        else
          current_user.groups.build(_task_params)
        end
    end
    helper_method :group
  end
end