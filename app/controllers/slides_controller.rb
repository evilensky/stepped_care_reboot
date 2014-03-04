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

  # def sort
  #   slide = Slide.find(params[:slide_id])
  #   new_position = params[:position].to_i
  #   slide_position = slide.position
  #   other_slide = slide.slideshow.slides.find_by_position(new_position)
  #   puts "other_slide =#{other_slide}"
  #   slide.position = new_position
  #   other_slide.position = slide_position
  #   [ ["#{slide.id}", new_position.to_i], ["#{other_slide.id}", slide_position.to_i] ].each do | array |
  #     Slide.where(:slideshow_id => slide.slideshow_id).update_all({position: array[1]}, {id: array[0]})
  #   end
  #   redirect_to slideshow_path(slide.slideshow)
  # end

  def sort
    params[:slide].each_with_index do |id, index|
      Slide.where({slideshow_id: params[:slideshow_id]}).update_all({position: index+1}, {id: id})
    end
    # redirect_to slideshow_path(slide.slideshow)
    render nothing: true
  end

private

  def slide_params 
    params.require(:slide).permit(:body, :position, :title)
  end

end
