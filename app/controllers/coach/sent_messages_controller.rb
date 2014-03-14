module Coach
  class SentMessagesController < ApplicationController
    before_filter :authenticate_user!
    layout 'coach'

    def show
      render(
        template: 'messages/show',
        locals: {
          message: current_user.sent_messages.find(params[:id])
        }
      )
    end
  end
end
