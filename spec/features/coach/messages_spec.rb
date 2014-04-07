require "spec_helper"

describe "coach messages" do
  fixtures :users, :participants, :coach_assignments, :messages, :delivered_messages

  before(:each) do
    sign_in_user users(:user1)
    visit "/coach/messages"
  end

  it "should allow a coach to compose and submit a new message" do
    click_on("Compose")
    select("participant1@example.com", from: "To")
    fill_in("Subject", with: "some new message")
    fill_in("Message", with: "some body")
    click_on("Send")

    expect(page).to have_text("Message saved")
  end

  it "should allow a coach to see messages from their participants" do
    expect(page).to have_text(delivered_messages(:participant_to_coach1).subject)
  end

  it "should not allow a coach to see messages from another coach's participants" do
    expect(page).to_not have_text(delivered_messages(:participant_to_coach2).subject)
  end

  it "should not allow a coach to compose a message to another coach's participants" do
    CoachAssignment.create(:coach_id => users(:user2).id, :participant_id => participants(:participant2).id)
    click_on("Compose")
    expect(page).to_not have_text(participants(:participant2).email)
  end
end
