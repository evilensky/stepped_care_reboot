# Enables Slideshow CRUD functionality.
class SlideshowsController < ApplicationController
  before_action :authenticate_user!

  def index
    @slideshows = BitPlayer::Slideshow.all
  end

  def new
    @slideshow = BitPlayer::Slideshow.new
  end

  def create
    @slideshow = BitPlayer::Slideshow.create(slideshow_params)
    if @slideshow.save
      flash[:success] = "Successfully created slideshow"
      redirect_to slideshows_path
    else
      flash[:alert] = @slideshow.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
    @slideshow = BitPlayer::Slideshow.find(params[:id])
    @slides = @slideshow.slides
  end

  def edit
    @slideshow = BitPlayer::Slideshow.find(params[:id])
  end

  def update
    @slideshow = BitPlayer::Slideshow.find(params[:id])
    if @slideshow.update(slideshow_params)
      flash[:success] = "Successfully updated slideshow"
      redirect_to slideshows_path
    else
      flash[:alert] = @slideshow.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @slideshow = BitPlayer::Slideshow.find(params[:id])
    if @slideshow.destroy
      flash[:success] = "Slideshow deleted."
      redirect_to slideshows_path
    else
      flash[:error] = "There were errors."
      redirect_to slideshows_path
    end
  end

  private

  def slideshow_params
    params.require(:slideshow).permit(:title)
  end

  def group_slideshow_joins
    @group_slideshow_joins ||= GroupSlideshowJoin
      .where(bit_player_slideshow_id: params[:id])
      .joins(:group).order("groups.title asc, release_day asc")
  end
  helper_method :group_slideshow_joins

end
