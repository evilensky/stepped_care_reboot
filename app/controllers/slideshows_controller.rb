class SlideshowsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @slideshows = Slideshow.all
  end

  def new
    @slideshow = Slideshow.new
  end

  def create
    @slideshow = Slideshow.create(slideshow_params)
    if @slideshow.save
      flash[:success] = "Successfully created slideshow"
      redirect_to slideshows_path
    else
      flash[:alert] = @slideshow.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @slideshow = Slideshow.find(params[:id])
    @slides = @slideshow.slides
  end

  def edit
    @slideshow = Slideshow.find(params[:id])
  end

  def update
    @slideshow = Slideshow.find(params[:id])
    if @slideshow.update(slideshow_params)
      flash[:success] = "Successfully updated slideshow"
      redirect_to slideshows_path
    else
      flash[:alert] = @slideshow.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @slideshow = Slideshow.find(params[:id])
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

end
