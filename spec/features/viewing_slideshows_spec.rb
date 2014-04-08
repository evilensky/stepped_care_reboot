# TO DO: CONVERT TO TASKS
require "spec_helper"

describe "participant1 learns via slideshows" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :group_slideshow_joins
  )

  before do
    sign_in_participant participants(:participant1)
    visit "/navigator/contexts/library"
  end

  it "can select what to learn" do
    expect(page).to have_link("Lessons")
    # expect(page).to have_link("Videos")
  end

  it "can view assigned slideshow that are released" do
    click_on "Lessons"
    expect(page).to have_link("Learning is wonderful!")
    expect(page).to have_link("Happiness")
    expect(page).not_to have_link("This slide is ONLY AVAILABLE ON DAY 3!")
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

describe "participant3 learns via slideshows" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :memberships, :group_slideshow_joins
  )

  before do
    sign_in_participant participants(:participant3)
    visit "/navigator/contexts/library"
  end

  it "participant3 can view assigned slideshow that are released because their start date was earlier" do
    click_on "Lessons"
    expect(page).to have_link("Learning is wonderful!")
    expect(page).to have_link("Happiness")
    expect(page).to have_link("This slide is ONLY AVAILABLE ON DAY 3!")
  end
end