require 'spec_helper'

describe 'Slideshow' do
  fixtures :users, :slideshows

  before do
    sign_in_user users(:user1)
    visit slideshows_path
  end

  it 'User can create a slideshow' do
    expect(Slideshow.find_by_title("My favorite Slideshow")).to be_nil
    click_on "New"
    fill_in "Title", with: "My favorite Slideshow"
    click_on "Create"
    expect(current_path).to eq slideshows_path
    expect(Slideshow.find_by_title("My favorite Slideshow")).not_to be_nil
    expect(page).to have_text("My favorite Slideshow")
  end

  it 'User will see error if no title is included' do
    click_on "New"
    fill_in "Title", with: ""
    click_on "Create"
    expect(page).to have_text("Title can't be blank")
  end

  it 'User can view show page of a slideshow' do
    click_on "I'm a test!"
    slideshow = Slideshow.find_by_title("I'm a test!")
    expect(current_path).to eq slideshow_path(slideshow)
    expect(page).to have_text("I'm a test!")
  end

  it 'User can update slideshow\'s title' do
    slideshow = Slideshow.find_by_title("I'm a test!")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Edit"
    end
    fill_in "Title", with: "This is no longer a TEST!"
    click_on "Update"
    slideshow.reload
    expect(slideshow.title).not_to eq "I'm a test!"
    expect(slideshow.title).to eq "This is no longer a TEST!"
    expect(current_path).to eq slideshows_path
  end

  it 'User can\'t update a slideshow without a title' do
    slideshow = Slideshow.find_by_title("I'm a test!")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Edit"
    end
    fill_in "Title", with: ""
    click_on "Update"
    expect(page).to have_text("Title can't be blank")
    slideshow.reload
    expect(slideshow.title).not_to eq ""
    expect(slideshow.title).to eq "I'm a test!"
  end

  it 'User can delete a slideshow' do
    expect(page).to have_text("I'm a test!")
    expect(Slideshow.find_by_title("I'm a test!")).not_to eq nil
    slideshow = Slideshow.find_by_title("I'm a test!")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Delete"
    end
    expect(Slideshow.find_by_title("I'm a test!")).to eq nil
    expect(page).to_not have_text("I'm a test!")
  end

end
