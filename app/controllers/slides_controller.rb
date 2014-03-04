class SlidesController < ApplicationController

  def new
    @slideshow = Slideshow.find(params[:slideshow_id])
    @slide = @slideshow.slides.build(params[:slide])
  end

  def create
    @slideshow = Slideshow.find(params[:slideshow_id])
    @slide = @slideshow.slides.build(slide_params)
    @slide.position = @slideshow.slides.count + 1
    if @slide.save
      flash[:success] = "Successfully created slide for slideshow"
      redirect_to slideshow_path(@slideshow)
    else
      flash.now[:alert] = @slide.errors.full_messages.join(', ')
      render :new
    end
  end

  def show
    @slide = Slide.find(params[:id])
  end

  def edit
    @slide = Slide.find(params[:id])
  end

  def update
    @slide = Slide.find(params[:id])
    if @slide.update(slide_params)
      flash[:success] = "Successfully updated slide for slideshow"
      redirect_to slideshow_path(@slide.slideshow)
    else
      flash.now[:alert] = @slide.errors.full_messages.join(', ')
      render :edit
    end
  end

  def destroy
    @slide = Slide.find(params[:id])
    if @slide.destroy
      flash[:success] = "Slide deleted."
      redirect_to slideshow_path(@slide.slideshow)
    else
      flash[:error] = "There were errors."
      redirect_to slideshow_path(@slide.slideshow)
    end
  end

  def sort
    slideshow = Slideshow.find(params[:slideshow_id])
    if slideshow.slides.update_positions(params[:slide])
      flash.now[:success] = "Reorder was successful."
      render nothing: true
    else
      flash.now[:alert] = slideshow.errors.full_messages.join(', ')
      render nothing: true
    end
  end

private

  def slide_params 
    params.require(:slide).permit(:body, :position, :title)
  end

end
