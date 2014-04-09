require "spec_helper"

describe "learn via slideshows" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/tools", :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :tasks, :task_status
  )

  describe "participant1 is logged in" do

    before do
      sign_in_participant participants(:participant1)
      visit "/navigator/contexts/LEARN"
    end

    it "can view assigned slideshow that are released" do
      save_and_open_page
      expect(page).to have_link("Do - Awareness Introduction")
      expect(page).not_to have_link("Do - Planning Introduction")
    end

  end

  describe "participant2" do

    before do
      sign_in_participant participants(:participant2)
      visit "/navigator/contexts/LEARN"
    end

    it "participant2 can view assigned slideshow that are released because their start date was earlier" do
      expect(page).to have_link("Do - Awareness Introduction")
      expect(page).to have_link("Do - Planning Introduction")
    end

  end

end