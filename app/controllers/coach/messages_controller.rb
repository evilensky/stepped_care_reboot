class Coach::MessagesController < ApplicationController
  before_filter :authenticate_user!
  layout 'coach'

  def index
    render(
      locals: {
        received_messages: current_user.received_messages,
        sent_messages: current_user.sent_messages
      }
    )
  end

  def new
    render(
      locals: {
        message: current_user.sent_messages.build,
        participants: current_user.participants
      }
    )
  end

  def create
    @message = current_user.sent_messages.build(message_params)

    if @message.save
      redirect_to coach_messages_url, notice: "Message saved"
    else
      flash.now[:alert] = "Unable to save message: #{ @message.errors.full_messages.join(', ') }"
      render :new
    end
  end

  private

  def message_params
    params.require(:message).permit(:recipient_id, :recipient_type, :subject, :body)
  end
end
