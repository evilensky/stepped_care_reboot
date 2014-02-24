class ActivityTrackersController < ApplicationController
  def show
    session[:context] = 'activity_tracker'
    session[:provider_position] = 0
    @navigator = Navigator.new(session)
    session[:provider_position] = 0
  end
end
