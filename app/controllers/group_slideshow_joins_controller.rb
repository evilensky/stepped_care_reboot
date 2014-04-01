# Enables users to edit the slideshows for each group
class GroupSlideshowJoinsController < ApplicationController
  before_action :authenticate_user!

  def create
    if group_slideshow_join.save
      redirect_to edit_group_path(group), notice: "Slideshow was assigned."
    else
      errors = group_slideshow_join.errors.full_messages.join(", ")
      flash[:alert] = "Unable to assign slideshow: #{ errors }"
      redirect_to edit_group_path(group_slideshow_join.group)
    end
  end

  def edit
  end

  def update
    if group_slideshow_join.update(_params)
      redirect_to edit_group_path(group), notice: "Updated successfully."
    else
      errors = group_slideshow_join.errors.full_messages.join(", ")
      flash[:alert] = "Unable to assign slideshow to group: #{ errors }"
      render :edit
    end
  end

  def destroy
    deleted_group = group_slideshow_join.group
    if group_slideshow_join.destroy
      flash.now[:success] = "Slideshow unassigned from group."
      redirect_to edit_group_path(deleted_group)
    else
      errors = group_slideshow_join.errors.full_messages.join(", ")
      flash[:error] = "Unable to assign slideshow to group: #{ errors }"
      redirect_to edit_group_path(deleted_group)
    end
  end

  private

  def _params
    params.require(:group_slideshow_join)
      .permit(:bit_player_slideshow_id, :group_id, :release_day)
  end

  def group_slideshow_join
    @group_slideshow_join ||=
      if params[:id]
        GroupSlideshowJoin.find(params[:id])
      else
        current_user.group_slideshow_joins.build(_params)
      end
  end
  helper_method :group_slideshow_join

  def group
    @group ||= group_slideshow_join.group
  end
  helper_method :group

  def slideshows
    @slideshows ||= BitPlayer::Slideshow.all
  end
  helper_method :slideshows
end