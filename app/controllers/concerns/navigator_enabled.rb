module Concerns
  module NavigatorEnabled
    extend ActiveSupport::Concern

    private

    def instantiate_navigator
      @navigator ||= Navigator.new(current_participant)
    end
  end
end
