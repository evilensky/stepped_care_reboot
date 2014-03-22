# Enables users to assign content to participants.
class GroupSlideshowJoinsController < ApplicationController
  before_action :authenticate_user!

  def new
    @slideshow = BitPlayer::Slideshow.find(params[:slideshow_id]) if params[:slideshow_id]
    @groups = Group.all
    @slideshows = BitPlayer::Slideshow.all
    @group_slideshow_join = GroupSlideshowJoin.new
  end

  def create
    @slideshow = BitPlayer::Slideshow.find(params[:slideshow_id]) if params[:slideshow_id]
    @groups = Group.all
    @slideshows = BitPlayer::Slideshow.all
    @group_slideshow_join = current_user.group_slideshow_joins.build(gsj_params)
    if @group_slideshow_join.save
      redirect_to group_slideshow_join_path(@group_slideshow_join), notice: "Message saved"
    else
      errors = @group_slideshow_join.errors.full_messages.join(", ")
      flash.now[:alert] = "Unable to assign slideshow to group: #{ errors }"
      render :new
    end
  end

  def show
    @group_slideshow_join = GroupSlideshowJoin.find(params[:id])
  end

  def edit
    @slideshow = BitPlayer::Slideshow.find(params[:slideshow_id]) if params[:slideshow_id]
    @groups = Group.all
    @slideshows = BitPlayer::Slideshow.all
    @group_slideshow_join = GroupSlideshowJoin.find(params[:id])
  end

  def update
    @slideshow = BitPlayer::Slideshow.find(params[:slideshow_id]) if params[:slideshow_id]
    @groups = Group.all
    @slideshows = BitPlayer::Slideshow.all
    @group_slideshow_join = GroupSlideshowJoin.find(params[:id])
    if @group_slideshow_join.update(gsj_params)
      redirect_to group_slideshow_join_path(@group_slideshow_join), notice: "Message saved"
    else
      errors = @group_slideshow_join.errors.full_messages.join(", ")
      flash.now[:alert] = "Unable to assign slideshow to group: #{ errors }"
      render :new
    end
  end

  private

  def gsj_params
    params.require(:group_slideshow_join).permit(:bit_player_slideshow_id, :group_id, :release_day)
  end

end
