class SlideshowsController < ApplicationController

  def index
    @slideshows = Slideshow.all
  end

  def new
    @slideshow = Slideshow.new
  end

  def create
    if @slideshow = Slideshow.create(params[:slideshow])
      # success
    else
      # error handling
    end
  end

  def create
    @slideshow = Slideshow.create(slideshow_params)
    if @slideshow.save
      flash[:success] = "Successfully created slideshow"
      redirect_to slideshows_path
    else
      flash.now[:alert] = @slideshow.errors.full_messages.join(', ')
      respond_to do |format|
        format.html { render text: @slideshow.errors.full_messages }
        # format.js { render status: 400 }
      end
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
      flash.now[:alert] = @slideshow.errors.full_messages.join(', ')
      respond_to do |format|
        format.html { render text: @slide.errors.full_messages }
        # format.js { render status: 400 }
      end
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
