class ContentProviders::ModuleIndexProvider < ContentProvider
  def render_current(options)
    options.view_context.render(template: 'content_modules/index', locals: {
        content_modules: ContentModule.where(context: options.app_context)
      }
    )
  end

  def exists?(position)
    false
  end

  def show_nav_link?
    false
  end
end
