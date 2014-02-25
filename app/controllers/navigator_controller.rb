class NavigatorController < ApplicationController
  before_filter :authenticate_participant!

  def show_context
    @navigator = Navigator.new(session)
    @navigator.initialize_context(params[:context_name] || 'home')
    render 'show_content'
  end

  def show_next_content
    @navigator = Navigator.new(session)
    @navigator.fetch_next_content
    render 'show_content'
  end
end
