module Concerns
  module NavigatorEnabled
    extend ActiveSupport::Concern

    private

    def instantiate_navigator
      @navigator ||= Navigator.new(session)
    end
  end
end
