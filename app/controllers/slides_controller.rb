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
      respond_to do |format|
        format.html { render text: @slide.errors.full_messages }
        # format.js { render status: 400 }
      end
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
      respond_to do |format|
        format.html { render text: @slide.errors.full_messages }
        # format.js { render status: 400 }
      end
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

private

  def slide_params 
    params.require(:slide).permit(:body, :position, :title)
  end

end
