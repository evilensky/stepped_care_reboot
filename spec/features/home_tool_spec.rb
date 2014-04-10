require "spec_helper"

describe "home tool" do
  fixtures(
    :participants, :memberships, :"bit_player/slideshows",
    :"bit_player/slides", :"bit_player/tools",
    :"bit_player/content_modules", :"bit_player/content_providers"
  )

  it "should have the correct content" do
    sign_in_participant participants(:participant3)
    visit "/"

    expect(page).to have_text("It's simple")

    click_on "Continue"

    expect(page).to have_text("Log in once a day")

    click_on "Continue"

    expect(page).to have_text("Come back every day")

    click_on "Continue"

    # video page

    click_on "Continue"

    expect(page).to have_text("It's simple")
  end
end
