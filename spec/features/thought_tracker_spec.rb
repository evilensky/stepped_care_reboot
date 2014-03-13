require "spec_helper"

describe "thought tracker" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers"
  )

  before do
    sign_in_participant participants(:participant1)
    visit "/navigator/contexts/thought_tracker"
  end

  it "should implement #1 Identifying" do
    click_on bit_player_content_modules(:think_identifying).title

    expect(page).to have_text(bit_player_slides(:think_identifying_intro1).title)

    find(".next-button").click

    expect(page).to have_text(bit_player_slides(:think_identifying_intro2).title)

    find(".next-button").click

    expect(page).to have_text(bit_player_slides(:think_identifying_intro3).title)

    find(".next-button").click

    expect(page).to have_text(bit_player_slides(:think_identifying_intro4).title)

    find(".next-button").click

    expect(page).to have_text("Now, your turn...")

    fill_in("thought_content", with: "my great thought")
    choose("thought_effect_helpful")
    click_on("Continue")

    expect(page).to have_text("Now list a few more...")

    fill_in("thought_content", with: "another thought")
    choose("thought_effect_neither")
    click_on("Continue")

    expect(page).to have_text("Good work")

    click_on("Continue")

    expect(page).to have_text("#1 Identifying")
  end

  it "should implement #2 Patterns" do
    click_on bit_player_content_modules(:think_patterns).title

    expect(page).to have_text(bit_player_slides(:think_patterns_intro1).title)
  end
end
