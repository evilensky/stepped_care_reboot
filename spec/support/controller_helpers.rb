module ControllerHelpers
  def sign_in_participant(participant = double("participant"))
    if participant.nil?
      expect(request.env["warden"]).to receive(:authenticate!)
        .and_throw(:warden, scope: :participant)
      controller.stub current_participant: nil
    else
      expect(request.env["warden"]).to receive(:authenticate!) { participant }
      expect(controller).to receive(:current_participant).at_least(:once) { participant }
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
end
