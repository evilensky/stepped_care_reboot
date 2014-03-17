module Participant
  # Enables viewing of a participant's received messages.
  class ReceivedMessagesController < ApplicationController
    before_filter :authenticate_participant!

    def index
      @received_messages = current_participant.received_messages
    end
  end
end
