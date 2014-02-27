class NavigatorController < ApplicationController
  before_action :authenticate_participant!, :instantiate_navigator

  def show_context
    @navigator.initialize_context(params[:context_name] || 'home')
    render 'show_content'
  end

  def show_module
    begin
      @navigator.initialize_module(params[:module_id])
    rescue ActiveRecord::RecordNotFound
      @navigator.initialize_context('home')
      flash[:alert] = 'Unable to find that module.'
    ensure
      render 'show_content'
    end
  end

  def show_next_content
    @navigator.fetch_next_content
    render 'show_content'
  end

  private

  def instantiate_navigator
    @navigator = Navigator.new(session)
  end
end
