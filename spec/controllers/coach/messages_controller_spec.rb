require "spec_helper"

describe Coach::MessagesController do
  shared_examples "a rejected action" do
    it "should redirect to the login" do
      expect(response).to redirect_to "#{ root_url }users/sign_in"
    end
  end

  describe "GET index" do
    context "for unauthenticated requests" do
      before { get :index }
      it_behaves_like "a rejected action"
    end

    context "for authenticated requests" do
      let(:user) { double("user", received_messages: [], sent_messages: []) }

      before { sign_in_user user }

      it "should render the coach messages index" do
        get :index
        expect(response).to render_template :index
      end
    end
  end

  describe "GET new" do
    context "for unauthenticated requests" do
      before { get :new }
      it_behaves_like "a rejected action"
    end

    context "for authenticated requests" do
      let(:user) { double("user", participants: [], build_sent_message: []) }

      before { sign_in_user user }

      it "should render the new coach message form" do
        get :new
        expect(response).to render_template :new
      end
    end
  end
end
