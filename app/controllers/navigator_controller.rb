class NavigatorController < ApplicationController
  include Concerns::NavigatorEnabled

  before_action :authenticate_participant!, :instantiate_navigator

  layout :switch_layout

  def show_context
    @navigator.initialize_context(params[:context_name] || 'home')
    render 'show_content'
  end

  def show_location
    begin
      @navigator.initialize_location(
        module_id: params[:module_id],
        provider_id: params[:provider_id],
        content_position: params[:content_position]
      )
    rescue ActiveRecord::RecordNotFound
      @navigator.initialize_context('home')
      flash[:alert] = 'Unable to find that module.'
    ensure
      render 'show_content'
    end
  end

  def show_next_content
    @navigator.fetch_next_content
    redirect_to navigator_location_path(
      module_id: @navigator.current_module.id,
      provider_id: @navigator.current_content_provider.id,
      content_position: @navigator.content_position
    )
  end

private

  def switch_layout
    if @navigator.context == 'home' || @navigator.current_module.position == 1
      'landing'
    else
      'tool'
    end
  end
end
