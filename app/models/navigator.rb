class Navigator
  def initialize(state)
    context = state[:context]
    module_position = state[:module_position]
    @current_module = ContentModule.where(context: context, position: module_position).first
    current_module.provider_index = state[:provider_index]
  end

  def render_current_content(view_context)
    current_content_provider.render_current(view_context)
  end

  def current_content_provider
    current_module.current_content_provider
  end

  def next_action_label
    current_content_provider.has_more_content? ? 'Continue' : 'Finish'
  end

  def next_path
    if current_content_provider.has_more_content?
      'next_content'
    elsif current_module.has_more_providers?
      'next_provider'
    else
      '/'
    end
  end

  def current_module
    @current_module || ContentModule.new
  end
end
