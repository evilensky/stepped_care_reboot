class HomeController < ApplicationController
  def index
    session[:context] = 'home'
    session[:module_position] ||= 1
    session[:provider_position] ||= 1
    session[:content_position] ||= 1
    @navigator = Navigator.new(session)
  end
end
