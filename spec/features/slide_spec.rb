require 'spec_helper'

describe 'Slides' do
  fixtures :users, :'bit_player/slideshows', :'bit_player/slides'

  before do
    sign_in_user users(:user1)
    visit slideshow_path(bit_player_slideshows(:rspec_slideshow))
  end

  it 'User can create a slide' do
    expect(BitPlayer::Slide.find_by_title("A great slide!!")).to be_nil
    click_on "New Slide"
    fill_in "Title", with: "A great slide!!"
    fill_in "Body", with: "The greatest content ever!"
    click_on "Create"
    expect(current_path).to eq slideshow_path(bit_player_slideshows(:rspec_slideshow))
    expect(BitPlayer::Slide.find_by_title("A great slide!!")).not_to be_nil
    expect(page).to have_text("A great slide!!")
  end

  it 'User will see error if no title is included' do
    click_on "New Slide"
    fill_in "Title", with: ""
    click_on "Create"
    expect(page).to have_text("Title can't be blank")
    expect(page).to have_text("Body can't be blank")
  end

  it 'User can view show page of a slide' do
    slide = BitPlayer::Slide.find_by_title("I'm an rspec slide")
    click_on "I'm an rspec slide"
    expect(current_path).to eq slideshow_slide_path(bit_player_slideshows(:rspec_slideshow), slide)
    expect(page).to have_text("I'm an rspec slide")
  end

  it "User can update slide's title (and body)" do
    slide = BitPlayer::Slide.find_by_title("I'm an rspec slide")
    with_scope "#slide_#{slide.id}" do
      expect(page).to have_text("Edit")
    end
    click_on "I'm an rspec slide"
    click_on "Edit"
    fill_in "Title", with: "This is no longer rspec, it is rspoo"
    fill_in "Body", with: "BIG BODY!"
    click_on "Update"
    slide.reload
    expect(slide.title).not_to eq "I'm an rspec slide"
    expect(slide.title).to eq "This is no longer rspec, it is rspoo"
    expect(slide.body).not_to eq "I'm serious!"
    expect(slide.body).to eq "BIG BODY!"
    expect(current_path).to eq slideshow_path(bit_player_slideshows(:rspec_slideshow))
  end

  it "User can't update a slide without a title" do
    slide = BitPlayer::Slide.find_by_title("I'm an rspec slide")
    click_on "I'm an rspec slide"
    click_on "Edit"
    fill_in "Title", with: ""
    click_on "Update"
    expect(page).to have_text("Title can't be blank")
    slide.reload
    expect(slide.title).not_to eq ""
    expect(slide.title).to eq "I'm an rspec slide"
  end

  it 'User can delete a slide' do
    expect(page).to have_text("I'm an rspec slide")
    slide = BitPlayer::Slide.find_by_title("I'm an rspec slide")
    expect(slide).not_to eq nil
    with_scope "#slide_#{slide.id}" do
      click_on "Delete"
    end
    expect(BitPlayer::Slide.find_by_title("I'm an rspec slide")).to eq nil
    expect(page).not_to have_text("I'm an rspec slide")
  end

end
