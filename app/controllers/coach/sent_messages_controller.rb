module Coach
  # Enables viewing of messages sent by coaches.
  class SentMessagesController < ApplicationController
    before_action :authenticate_user!
    layout "coach"

    def show
      render(
        template: "messages/show",
        locals: {
          message: current_user.sent_messages.find(params[:id])
        }
      )
    end
  end
end
