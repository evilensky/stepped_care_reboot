require "spec_helper"

describe "messages" do
  fixtures(
    :participants, :memberships, :users, :messages, :delivered_messages,
    :"bit_player/content_modules", :"bit_player/content_providers",
    :"bit_player/slideshows", :"bit_player/slides", :coach_assignments
  )

  before do
    sign_in_participant participants(:participant1)
    visit "/navigator/contexts/messages"
  end

  it "should allow a participant to compose and submit a new message" do
    click_on("Compose")
    fill_in("Subject", with: "some new message")
    fill_in("Message", with: "some body")
    click_on("Send")

    expect(page).to have_text("Message saved")
  end

  it "should display the number of unread messages in the inbox" do
    expect(page).to have_text("Inbox (1)")
  end

  it "should display all messages" do
    expect(page).to have_text("Try out the LEARN tool")
    expect(page).to have_text("I like this app")
  end

  it "should show a message" do
    click_on("I like this app")

    expect(page).to have_text("This app is really helpful!")
  end
end
