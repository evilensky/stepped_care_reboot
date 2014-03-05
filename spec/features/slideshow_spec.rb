require 'spec_helper'

describe 'Slideshow' do
  fixtures :users, :slideshows

  before do
    sign_in_user users(:user1)
    visit slideshows_path
  end

  it 'User can create a slideshow' do
    Slideshow.find_by_title("My favorite Slideshow").should be_nil
    click_on "New"
    fill_in "Title", with: "My favorite Slideshow"
    click_on "Create"
    current_path.should == slideshows_path
    Slideshow.find_by_title("My favorite Slideshow").should_not be_nil
    page.should have_content("My favorite Slideshow")
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
    current_path.should == slideshow_path(slideshow)
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
    slideshow.title.should_not == "I'm a test!"
    slideshow.title.should == "This is no longer a TEST!"
    current_path.should == slideshows_path
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
    slideshow.title.should_not == ""
  end

  it 'User can delete a slideshow' do
    expect(page).to have_text("I'm a test!")
    Slideshow.find_by_title("I'm a test!").should_not be_nil
    slideshow = Slideshow.find_by_title("I'm a test!")
    with_scope "#slideshow-#{slideshow.id}" do
      click_on "Delete"
    end
    Slideshow.find_by_title("I'm a test!").should be_nil
    expect(page).to_not have_text("I'm a test!")
  end

end
