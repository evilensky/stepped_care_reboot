require "spec_helper"

describe "home tool" do
  fixtures(
    :participants, :memberships, :"bit_player/slideshows",
    :"bit_player/slides", :"bit_player/tools",
    :"bit_player/content_modules", :"bit_player/content_providers"
  )

  it "should have the correct content" do
    sign_in_participant participants(:participant1)
    visit "/"

    expect(page).to have_text("It's simple")

    find(".next-button").click

    expect(page).to have_text("Log in once a day")

    find(".next-button").click

    expect(page).to have_text("Come back every day")
  end
end
