# Enables users to edit group_slideshows
# This code may need to be moved out and refactored
# if we nest slideshows also within Groups
class GroupSlideshowJoinsController < ApplicationController
  before_action :authenticate_user!

  def edit
  end

  def update
    puts "group_slideshow_join = #{group_slideshow_join.creator_id}"
    if group_slideshow_join.update(group_slideshow_join_params)
      # Not sure how this redirect will work out in the future
      # when we are updating slideshows nested within groups
      # Maybe just move this out into the slideshow_groups_controller
      redirect_to slideshow_path(slideshow), notice: "Updated successfully."
    else
      errors = group_slideshow_join.errors.full_messages.join(", ")
      puts "errors = #{errors}"
      flash.now[:alert] = "Unable to assign slideshow to group: #{ errors }"
      render :edit
    end
  end

  def destroy
    slideshow_for_after_delete = slideshow
    group_slideshow_join.destroy
    flash.now[:success] = "Slideshow unassigned form group."
    # Not sure how this redirect will work out in the future
    # when we are updating slideshows nested within groups
    # Maybe just move this out into the slideshow_groups_controller
    redirect_to slideshow_path(slideshow_for_after_delete)
  end

  private

  def group_slideshow_join_params
    params.require(:group_slideshow_join)
      .permit(:bit_player_slideshow_id, :group_id, :release_day)
  end

  def group_slideshow_join
    @group_slideshow_join ||= GroupSlideshowJoin.find(params[:id])
  end
  helper_method :group_slideshow_join

  def groups
    Group.all
  end
  helper_method :groups

  def slideshow
    group_slideshow_join.bit_player_slideshow
  end
  helper_method :slideshow
end