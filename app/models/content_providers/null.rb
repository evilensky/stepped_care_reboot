class ContentProviders::Null
  def render_current(view_context)
    'Null content provider'
  end

  def has_more_content?
    false
  end

  def show_nav_link?
  	true
  end
end
