module ControllerHelpers
  def sign_in_participant(participant = double("participant"))
    sign_in_resource(participant, "participant")
  end

  def sign_in_user(user = double("user"))
    sign_in_resource(user, "user")
  end

  private

  def sign_in_resource(resource, name)
    if resource.nil?
      expect(request.env["warden"]).to receive(:authenticate!)
        .and_throw(:warden, scope: :"#{ name }")
      controller.stub :"current_#{ name }" => nil
    else
      expect(request.env["warden"]).to receive(:authenticate!) { resource }
      expect(controller).to receive("current_#{ name }").at_least(:once)
        .and_return(resource)
    end
  end
end

RSpec.configure do |config|
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
end
