class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :authenticate_participant!

  layout :switch_layout

  private

    def switch_layout
      session[:context] == "home" ? "application" : "tool"
    end
end
