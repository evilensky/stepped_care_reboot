require "spec_helper"

describe Coach::ReceivedMessagesController do
  describe "GET index" do
    context "for unauthenticated requests" do
      before { get :index }
      it_behaves_like "a rejected user action"
    end

    context "for authenticated requests" do
      let(:user) { double("user", received_messages: []) }

      before { sign_in_user user }

      it "should render the coach received messages index" do
        xhr :get, :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET show" do
  end
end
