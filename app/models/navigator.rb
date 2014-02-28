class Navigator
  RenderOptions = Struct.new(:view_context, :app_context, :position, :participant)

  def initialize(state)
    @state = state
    context = @state[:context]
    module_position = @state[:module_position]
  end

  def render_current_content(view_context)
    options = RenderOptions.new(view_context, @state[:context],
        @state[:content_position], view_context.current_participant)

    current_content_provider.render_current(options)
  end

  def show_nav_link?
    current_content_provider.show_nav_link?
  end

  def current_content_provider
    current_module.provider(@state[:provider_position])
  end

  def next_action_label
    current_content_provider.exists?(@state[:content_position] + 1) ? 'Continue' : 'Finish'
  end

  def fetch_next_content
    if current_content_provider.exists?(@state[:content_position] + 1)
      @state[:content_position] += 1
    elsif current_module.provider_exists?(@state[:provider_position] + 1)
      @state[:content_position] = 1
      @state[:provider_position] += 1
    elsif ContentModule.exists?(context: @state[:context], position: @state[:module_position] + 1)
      initialize_context(@state[:context])
      @state[:module_position] = 1
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

  def initialize_location(options)
    content_module = ContentModule.find(options[:module_id])
    @state[:context] = content_module.context
    @state[:module_position] = content_module.position
    if options[:provider_id]
      @state[:provider_position] = content_module.providers.find(options[:provider_id]).position
    else
      @state[:provider_position] = 1
    end
    @state[:content_position] = [options[:content_position].to_i, 1].max
  end

  def current_module
    module_attrs = { context: @state[:context], position: @state[:module_position] }

    if current_module_stale?
      @current_module = ContentModule.where(module_attrs).first
    end

    @current_module ||= ContentModule.new(module_attrs)
  end

  private

  def current_module_stale?
    @current_module.nil? ||
      (@current_module.context != @state[:context] ||
       @current_module.position != @state[:module_position])
  end
end
