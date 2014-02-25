class ContentProviders::Null
  def render_current(options)
    'Null content provider'
  end

  def has_more_content?
    false
  end

  def show_nav_link?
  	true
  end
end
