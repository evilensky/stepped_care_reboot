require "spec_helper"

describe MessageNotifications do
  fixtures :users

  describe "new_for_coach" do
    let(:mail) { MessageNotifications.new_for_coach(users(:user1)) }

    it "renders the headers" do
      expect(mail.subject).to eq("New message")
      expect(mail.to).to eq([users(:user1).email])
      expect(mail.from).to eq(["from@example.com"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to match("You have a new message")
    end
  end

end
