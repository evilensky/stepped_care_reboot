require "spec_helper"

describe "participant1 learns via slideshows" do
  fixtures(
    :participants, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/tools",
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

describe "users CRUDing learning by assigning learning slideshows to groups" do
  fixtures(
    :users, :"bit_player/slideshows", :"bit_player/slides",
    :"bit_player/content_modules", :"bit_player/content_providers",
    :groups, :group_slideshow_joins
  )

  before do
    sign_in_user users(:user1)
  end

  it "can assign slideshow to group" do
    group = groups(:group1)
    bit_player_slideshow = bit_player_slideshows(:rspec_slideshow)
    visit slideshow_path(bit_player_slideshow)
    expect(page).not_to have_text(group.title)
    expect(page).not_to have_text(1)
    gsj = GroupSlideshowJoin.where(group_id: group.id, bit_player_slideshow_id: bit_player_slideshow.id)
    expect(gsj.first).to be_nil
    click_on "Assign"
    select("Group 1", from: "Select Group")
    fill_in("Select number of days into intervention to make available", with: 1)
    click_on("Save")
    expect(current_path).to eq slideshow_path(bit_player_slideshow)
    expect(gsj.first).not_to be_nil
    expect(gsj.first.group).to eq group
    expect(gsj.first.release_day).to eq 1
    expect(gsj.first.creator).to eq users(:user1)
    expect(page).to have_text(group.title)
    expect(page).to have_text(1)
  end

  it "can update slideshow to group" do
    gsj = group_slideshow_joins(:group_slideshow_join1)
    expect(gsj.group_id).to eq groups(:group1).id
    expect(gsj.release_day).to eq 1
    visit slideshow_path(gsj.bit_player_slideshow)
    with_scope "#group-slide-show-#{gsj.id}" do
      click_on "Edit"
    end
    select("Group 2", from: "Select Group")
    fill_in("Select number of days into intervention to make available", with: 2)
    click_on "Update"
    gsj.reload
    expect(gsj.group_id).to eq groups(:group2).id
    expect(gsj.release_day).to eq 2
  end

  it "validation that the same slideshow can't be assigned more than once" do
    visit slideshow_path(group_slideshow_joins(:group_slideshow_join1).bit_player_slideshow)
    click_on "Assign"
    select("Group 1", from: "Select Group")
    fill_in("Select number of days into intervention to make available", with: 1)
    click_on("Save")
    expect(page).to have_text("Unable to assign slideshow")
    expect(page).to have_text("Release day This slideshow has already been assigned and set to be released on this day to this group.")
  end

  it "can unassign slideshow to group" do
    gsj = group_slideshow_joins(:group_slideshow_join1)
    expect(GroupSlideshowJoin.where(id: gsj.id).count).not_to eq 0
    visit slideshow_path(gsj.bit_player_slideshow)
    with_scope "#group-slide-show-#{gsj.id}" do
      click_on "Remove"
    end
    expect(GroupSlideshowJoin.where(id: gsj.id).count).to eq 0
  end

end
