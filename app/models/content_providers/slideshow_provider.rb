class ContentProviders::SlideshowProvider < ContentProvider
  def slideshow
    source_content
  end

  def render_current(options)
    render_slide slide(options.position)
  end

  def render_slide(slide)
    slide.body
  end

  def slide(position)
    slideshow.slides.where(position: position).first || Slide.new(body: 'no slides')
  end

  def exists?(position)
    slideshow.slides.exists?(position: position)
  end

  def show_nav_link?
    true
  end
end
