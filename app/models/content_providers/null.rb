class ContentProviders::Null
  def render_current(view_context)
    'Null content provider'
  end

  def has_more_content?
    false
  end
end
