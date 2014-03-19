# Enables users to assign content to participants.
class SlideshowGroupsController < ApplicationController
  before_action :authenticate_user!

  def new
    @group_slideshow_join = current_user.group_slideshow_joins.build
  end

  def create
    @group_slideshow_join = current_user.group_slideshow_joins.build(group_slideshow_join_params)
    if @group_slideshow_join.save
      redirect_to slideshow_path(slideshow), notice: "Slideshow assigned to group successfully."
    else
      errors = @group_slideshow_join.errors.full_messages.join(", ")
      flash.now[:alert] = "Unable to assign slideshow to group: #{ errors }"
      render :new
    end
  end

  private

  def group_slideshow_join_params
    params.require(:group_slideshow_join).permit(:bit_player_slideshow_id, :group_id, :release_day)
  end

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
