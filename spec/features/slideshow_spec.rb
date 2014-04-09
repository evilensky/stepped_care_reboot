require "spec_helper"

describe "Slideshow" do
  fixtures :users, :"bit_player/slideshows"

  before do
    sign_in_user users(:user1)
    visit slideshows_path
  end

  it "User can create a slideshow" do
    expect(BitPlayer::Slideshow.find_by_title("My favorite Slideshow")).to be_nil
    click_on "New"
    fill_in "Title", with: "My favorite Slideshow"
    click_on "Create"
    expect(current_path).to eq slideshows_path
    expect(BitPlayer::Slideshow.find_by_title("My favorite Slideshow")).not_to be_nil
    expect(page).to have_text("My favorite Slideshow")
  end

  it "User will see error if no title is included" do
    click_on "New"
    fill_in "Title", with: ""
    click_on "Create"
    expect(page).to have_text("Title can't be blank")
  end

  it "User can view show page of a slideshow" do
    save_and_open_page
    click_on "Home Intro"
    slideshow = BitPlayer::Slideshow.find_by_title("Home Intro")
    expect(current_path).to eq slideshow_path(slideshow)
    expect(page).to have_text("Home Intro")
  end

  it "User can update slideshow\"s title" do
    slideshow = BitPlayer::Slideshow.find_by_title("Home Intro")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Edit"
    end
    fill_in "Title", with: "This is no longer a TEST!"
    click_on "Update"
    slideshow.reload
    expect(slideshow.title).not_to eq "Home Intro"
    expect(slideshow.title).to eq "This is no longer a TEST!"
    expect(current_path).to eq slideshows_path
  end

  it "User can\"t update a slideshow without a title" do
    slideshow = BitPlayer::Slideshow.find_by_title("Home Intro")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Edit"
    end
    fill_in "Title", with: ""
    click_on "Update"
    expect(page).to have_text("Title can't be blank")
    slideshow.reload
    expect(slideshow.title).not_to eq ""
    expect(slideshow.title).to eq "Home Intro"
  end

  it "User can delete a slideshow" do
    expect(page).to have_text("Home Intro")
    expect(BitPlayer::Slideshow.find_by_title("Home Intro")).not_to eq nil
    slideshow = BitPlayer::Slideshow.find_by_title("Home Intro")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Delete"
    end
    expect(BitPlayer::Slideshow.find_by_title("Home Intro")).to eq nil
    expect(page).to_not have_text("Home Intro")
  end

end
