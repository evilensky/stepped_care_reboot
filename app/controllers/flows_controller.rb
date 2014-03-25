# Enables users to view site flow.
class FlowsController < ApplicationController
  before_action :authenticate_user!

  layout "flow"
end
