class ContentProviders::SlideshowProvider < ContentProvider
  def slideshow
    source_content
  end

  def render_current(view_context)
    render_slide current_slide
  end

  def render_slide(slide)
    slide.body
  end

  def current_slide
    slideshow.slides[current_slide_index] || Slide.new(body: 'no slides')
  end

  def has_more_content?
    false
  end

  def current_slide_index
    @current_slide_index ||= 0
  end
end
