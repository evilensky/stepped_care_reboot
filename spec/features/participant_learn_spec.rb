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
      expect(page).to have_link("Do - Awareness Introduction")
      # ??? this task is released on day 1 so the link is visible
      # expect(page).not_to have_link("Do - Planning Introduction")
      click_on "Do - Awareness Introduction"
      content_module = bit_player_content_modules(:slideshow_content_module_2)
      provider = bit_player_content_providers(:content_provider_slideshow_2)
      expect(current_path).to eq "/navigator/modules/" + "#{content_module.id}" + "/providers/" + "#{provider.id}" + "/1"
      expect(page).to have_text("LEARN")
      expect(page).to have_text("Do - Awareness Introduction")
      expect(page).to have_text("This is just the beginning...")
    end

  end

  describe "participant2" do

    before do
      sign_in_participant participants(:participant2)
      visit "/navigator/contexts/LEARN"
    end

    it "participant2 can view assigned slideshows (with the correct slides) based on released day" do
      expect(page).to have_link("Do - Awareness Introduction")
      expect(page).to have_link("Do - Planning Introduction")
      click_on "Do - Planning Introduction"
      expect(page).to have_text("LEARN")
      expect(page).to have_text("Do - Planning Introduction")
      expect(page).to have_text("The last few times you were here...")
    end
  end
end
