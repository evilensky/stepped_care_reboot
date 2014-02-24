class ContentProviders::SlideshowProvider < ContentProvider
  def slideshow
    source_content
  end

  def render_current(view_context, content_position)
    render_slide slide(content_position)
  end

  def render_slide(slide)
    slide.body
  end

  def slide(position)
    slideshow.slides.where(position: position).first || Slide.new(body: 'no slides')
  end

  def fetch(position)
    @slide_position = position
  end

  def has_more_content?
    slide_position < slideshow.slides.count
  end

  def slide_position
    @slide_position ||= 1
  end

  def show_nav_link?
    true
  end

end
