class ActivityTrackersController < ApplicationController
  def show
    session[:context] = 'activity_tracker'
    session[:provider_index] = 0
    @navigator = Navigator.new(session)
  end
end
