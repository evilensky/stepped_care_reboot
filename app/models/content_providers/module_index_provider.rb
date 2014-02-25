class ContentProviders::ModuleIndexProvider < ContentProvider
  def render_current(view_context, app_context, position)
    view_context.render(template: 'content_modules/index', locals: {
        content_modules: ContentModule.where(context: app_context)
      }
    )
  end

  def has_more_content?
    false
  end

  def show_nav_link?
    false
  end
end
