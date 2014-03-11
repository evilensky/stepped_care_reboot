class Participant::ReceivedMessagesController < ApplicationController
  before_filter :authenticate_participant!

  def index
    @received_messages = current_participant.received_messages
  end
end
