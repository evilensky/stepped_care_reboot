class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  layout :switch_layout

  private

  def switch_layout
    if devise_controller?
      'devise'
    elsif session[:context] == 'home'
      'application'
    else
      'tool'
    end
  end
end
