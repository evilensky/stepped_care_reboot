# Enables users to assign content to participants.
class SlideshowGroupsController < ApplicationController
  before_action :authenticate_user!

  def new
  end

  def create
    if group_slideshow_join.save
      redirect_to slideshow_path(slideshow), notice: "Slideshow was assigned."
    else
      errors = group_slideshow_join.errors.full_messages.join(", ")
      flash.now[:alert] = "Unable to assign slideshow: #{ errors }"
      render :new
    end
  end

  private

  def _params
    if params[:group_slideshow_join]
      params.require(:group_slideshow_join)
        .permit(:bit_player_slideshow_id, :group_id, :release_day)
    end
  end

  def group_slideshow_join
    @group_slideshow_join ||= current_user.group_slideshow_joins.build(_params)
  end
  helper_method :group_slideshow_join

  def groups
    Group.all
  end
  helper_method :groups

  def slideshow
    if params[:slideshow_id]
      @slideshow ||= BitPlayer::Slideshow.find(params[:slideshow_id])
    else
      @slideshow ||= BitPlayer::Slideshow.new
    end
  end
  helper_method :slideshow
end