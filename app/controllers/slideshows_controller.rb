# Enables Slideshow CRUD functionality.
class SlideshowsController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def new
  end

  def create
    if slideshow.save
      flash[:success] = "Successfully created slideshow"
      redirect_to slideshows_path
    else
      flash[:alert] = slideshow.errors.full_messages.join(", ")
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if slideshow.update(slideshow_params)
      flash[:success] = "Successfully updated slideshow"
      redirect_to slideshows_path
    else
      flash[:alert] = slideshow.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    if slideshow.destroy
      flash[:success] = "Slideshow deleted."
      redirect_to slideshows_path
    else
      flash[:error] = "There were errors."
      redirect_to slideshows_path
    end
  end

  private

  def slideshow_params
    params.require(:slideshow).permit(:title) if params[:slideshow]
  end

  def group_slideshow_joins
    @group_slideshow_joins ||= GroupSlideshowJoin
      .where(bit_player_slideshow_id: params[:id])
      .joins(:group).order("groups.title asc, release_day asc")
  end
  helper_method :group_slideshow_joins

  def slideshow
    @slideshow  ||= if params[:id]
                      BitPlayer::Slideshow.find(params[:id])
                    else
                      BitPlayer::Slideshow.new(slideshow_params)
                    end
  end
  helper_method :slideshow

  def slideshows
    @slideshows ||= BitPlayer::Slideshow.all
  end
  helper_method :slideshows
end