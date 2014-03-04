class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  layout :switch_layout

  private

  def switch_layout
    if devise_controller?
      'devise'
    elsif session[:context] == 'home' || session[:module_position] == 1
      'application'
    else
      'tool'
    end
  end
end