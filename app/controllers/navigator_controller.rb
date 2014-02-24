class NavigatorController < ApplicationController
  def show
    @navigator = Navigator.new(session)
    @navigator.fetch_next_content
  end
end
