class Coach::ReceivedMessagesController < ApplicationController
  before_filter :authenticate_user!
  layout 'coach'

  def index
    @received_messages = current_user.received_messages
  end

  def show
    message = current_user.received_messages.find(params[:id])
    message.try(:mark_read)
    render(
      template: 'messages/show',
      locals: {
        message: message
      }
    )
  end
end
