class Navigator
  def initialize(state)
    @state = state
    context = @state[:context]
    module_position = @state[:module_position]
  end

  def render_current_content(view_context, &block)
    rendered = current_content_provider.render_current(view_context, @state[:content_position])
    if block && current_content_provider.show_nav_link?
      rendered += yield
    end

    rendered
  end

  def current_content_provider
    current_module.provider(@state[:provider_position])
  end

  def next_action_label
    current_content_provider.has_more_content? ? 'Continue' : 'Finish'
  end

  def fetch_next_content
    if current_content_provider.has_more_content?
      @state[:content_position] += 1
      current_content_provider.fetch(@state[:content_position])
    elsif current_module.provider_exists?(@state[:provider_position] + 1)
      @state[:content_position] = 0
      @state[:provider_position] += 1
    else
      initialize_context(@state[:context])
    end
  end

  def initialize_context(context)
    @state[:context] = context
    @state[:module_position] = 1
    @state[:provider_position] = 1
    @state[:content_position] = 1
  end

  private

  def current_module
    if current_module_stale?
      @current_module = ContentModule.where(context: @state[:context], position: @state[:module_position]).first
    end

    @current_module || ContentModule.new
  end

  def current_module_stale?
    @current_module.nil? ||
      (@current_module.context != @state[:context] ||
       @current_module.position != @state[:module_position])
  end
end
