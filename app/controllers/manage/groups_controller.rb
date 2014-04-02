# Users can view groups to CRUD and assign slideshows
module Manage
  class GroupsController < ApplicationController
    before_action :authenticate_user!
    layout "manage_group"

    def index
      respond_to do |format|
        format.html { render layout: 'basic' }
      end
    end

    def edit_slideshows
    end

    def edit_tasks
    end

    private

    def _slideshow_params
      if params[:group_slideshow_join]
        params.require(:group_slideshow_join)
          .permit(:bit_player_slideshow_id, :group_id, :release_day)
      end
    end

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

    def group_slideshow_join
      @group_slideshow_join ||= current_user.group_slideshow_joins.build(_slideshow_params)
    end
    helper_method :group_slideshow_join

    def group_slideshow_joins
      group.group_slideshow_joins.order("release_day ASC").all
    end
    helper_method :group_slideshow_joins

    def groups
      Group.all
    end
    helper_method :groups

    def group
      @group ||=
        if params[:id]
          Group.find(params[:id])
        elsif params[:group_slideshow_join]
          current_user.groups.build(_slideshow_params)
        else
          current_user.groups.build(_task_params)
        end
    end
    helper_method :group
  end
end