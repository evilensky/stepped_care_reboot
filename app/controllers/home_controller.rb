class HomeController < ApplicationController
  def index
    session[:context] = 'home'
    session[:module_position] ||= 1
    session[:provider_index] ||= 0
    @navigator = Navigator.new(session)
  end
end
