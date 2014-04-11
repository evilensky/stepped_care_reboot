require "spec_helper"

describe "thought tracker" do
  fixtures(
    :participants, :groups, :memberships, :"bit_player/slideshows",
    :"bit_player/slides", :"bit_player/tools", :"bit_player/content_modules",
    :"bit_player/content_providers", :tasks, :thoughts
  )

  before do
    sign_in_participant participants(:participant1)
    visit "/navigator/contexts/THINK"
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
    click_on "#2 Patterns"

    expect(page).to have_text "Like we said, you are what you think..."
  end

  it "should implement #3 Reshape" do
    click_on "#3 Reshape"

    expect(page).to have_text "Evidence is where it's at."

    click_on "Continue"

    expect(page).to have_text "You said you had the following unhelpful thoughts:"
    expect(page).to have_text "I am useless"
  end

  it "should implement 'Add a New Thought'" do
    click_on "Add a New Thought"

    expect(page).to have_text "Now, your turn..."

    fill_in("thought_content", with: "I like tomatoes")
    choose("thought_effect_neither")
    click_on("Continue")

    expect(page).to have_text("Add a New Thought")
  end
end
