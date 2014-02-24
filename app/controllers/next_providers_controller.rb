class NextProvidersController < ApplicationController
  def show
    session[:provider_index] ||= 0
    session[:provider_index] += 1
    redirect_to '/'
  end
end
