# Users can view groups to CRUD and assign slideshows
class GroupsController < ApplicationController
  before_action :authenticate_user!
  layout "manage"

  def index
  end

  def edit
  end

  private

  def _params
    if params[:group_slideshow_join]
      params.require(:group_slideshow_join)
        .permit(:bit_player_slideshow_id, :group_id, :release_day)
    end
  end

  def slideshows
    BitPlayer::Slideshow.all
  end
  helper_method :slideshows

  def group_slideshow_join
    @group_slideshow_join ||= current_user.group_slideshow_joins.build(_params)
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
      else
        current_user.groups.build(_params)
      end
  end
  helper_method :group
end