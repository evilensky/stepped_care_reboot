class ContentProviders::ModuleIndexProvider < ContentProvider
  def render_current(options)
    content_modules = ContentModule
      .where(context: options.app_context)
      .where.not(id: content_module_id)

    options.view_context.render(
      template: 'content_modules/index',
      locals: { content_modules: content_modules }
    )
  end

  def show_nav_link?
    false
  end
end
