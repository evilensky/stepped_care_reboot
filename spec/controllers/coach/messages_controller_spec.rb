require "spec_helper"

describe Coach::MessagesController do
  describe "GET index" do
    context "for unauthenticated requests" do
      before { get :index }
      it_behaves_like "a rejected user action"
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
      it_behaves_like "a rejected user action"
    end

    context "for authenticated requests" do
      let(:user) { double("user", participants: [], build_sent_message: nil) }

      before { sign_in_user user }

      it "should render the new coach message form" do
        get :new
        expect(response).to render_template :new
      end
    end
  end

  describe "POST create" do
    context "for unauthenticated requests" do
      before { post :create }
      it_behaves_like "a rejected user action"
    end

    context "for authenticated requests" do
      let(:user) { double("user", build_sent_message: message) }

      before { sign_in_user user }

      context "when the message saves" do
        let(:message) { double("message", save: true) }

        before do
          post :create, message: {
            recipient_id: 1, recipient_type: "foo", subject: "bar", body: "asdf"
          }
        end

        it { expect(response).to redirect_to coach_messages_url }
      end

      context "when the message does not save" do
        let(:errors) { double("errors", full_messages: []) }
        let(:message) { double("message", save: false, errors: errors) }

        before do
          post :create, message: {
            recipient_id: 1, recipient_type: "foo", subject: "bar", body: "asdf"
          }
        end

        it { expect(response).to render_template :new }
      end
    end
  end
end
