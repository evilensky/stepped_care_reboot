class Navigator
  def initialize(state)
    @state = state
    context = @state[:context]
    module_position = @state[:module_position]
    @current_module = ContentModule.where(context: context, position: module_position).first
    current_module.provider_position = @state[:provider_position]
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

  def fetch_next_content
    if current_content_provider.has_more_content?
      @state[:content_position] += 1
      current_content_provider.fetch_next
    elsif current_module.has_more_providers?
      @state[:content_position] = 0
      @state[:provider_position] += 1
    else
      #asdf
    end
  end

  def current_module
    @current_module || ContentModule.new
  end
end
