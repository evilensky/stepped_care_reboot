require "spec_helper"

describe "learning via slideshows" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/tools", :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :group_slideshow_joins
  )

  describe "participant1 is logged in" do

    before do
      sign_in_participant participants(:participant1)
      visit "/navigator/contexts/LEARN"
    end

    it "can select what to learn" do
      expect(page).to have_link("Lessons")
      # expect(page).to have_link("Videos")
    end

    it "can view assigned slideshow that are released" do
      click_on "Lessons"
      expect(page).to have_link("Home Intro")
      expect(page).not_to have_link("Congrats")
    end

    it "can view videos"# do
    #   click_on "Videos"
    #   expect(page).to have_link("Slide 4") # Giraffe & Hippo video
    #   click_on "Slide 4"
    #   video_slide = BitPlayer::VideoSlide.find_by_title("Slide 4")
    #   expect(current_path).to eq navigator_location_path(
    #     module_id: video_slide.slideshow.content_provider.content_module.id,
    #     provider_id: video_slide.slideshow.content_provider.id,
    #     content_position: video_slide.position
    #   )
    # end

  end

  describe "participant3" do

    before do
      sign_in_participant participants(:participant3)
      visit "/navigator/contexts/LEARN"
    end

    it "participant3 can view assigned slideshow that are released because their start date was earlier" do
      click_on "Lessons"
      expect(page).to have_link("Home Intro")
      expect(page).to have_link("Congrats")
    end

  end

end