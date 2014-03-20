require 'spec_helper'

describe 'learning for participants' do
  fixtures(
    :participants, :'bit_player/slideshows', :'bit_player/slides',
    :'bit_player/content_modules', :'bit_player/content_providers',
    :groups, :memberships, :group_slideshow_joins
  )

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/library'
  end

  it 'can select what to learn' do
    expect(page).to have_link('Lessons')
    expect(page).to have_link('Videos')
  end

  it 'can view assigned slideshow that are released' do
    click_on "Lessons"
    expect(page).to have_link('1 Learning is wonderful!')
  end

  it 'can view assigned slideshows that are not released yet'

end

describe 'learning for users' do
  fixtures(
    :users, :'bit_player/slideshows', :'bit_player/slides',
    :'bit_player/content_modules', :'bit_player/content_providers',
    :groups, :group_slideshow_joins
  )

  before do
    sign_in_user users(:user1)
  end

  it 'can assign slideshow to group' do
    group = groups(:group1)
    bit_player_slideshow = bit_player_slideshows(:rspec_slideshow)
    visit slideshow_path(bit_player_slideshow)
    expect(page).not_to have_text(group.title)
    expect(page).not_to have_text(1)
    gsj = GroupSlideshowJoin.where(group_id: group.id, bit_player_slideshow_id: bit_player_slideshow.id)
    expect(gsj.first).to be_nil
    click_on "Assign"
    select('Group 1', from: "Select Group")
    fill_in('Select number of days into intervention to make available', with: 1)
    click_on('Save')
    expect(current_path).to eq slideshow_path(bit_player_slideshow)
    expect(gsj.first).not_to be_nil
    expect(gsj.first.group).to eq group
    expect(gsj.first.release_day).to eq 1
    expect(gsj.first.creator).to eq users(:user1)
    expect(page).to have_text(group.title)
    expect(page).to have_text(1)
  end

  it 'can update slideshow to group'
  #   gsj = group_slideshow_joins(:group_slideshow_join1)
  #   expect(gsj.group_id).to eq groups(:group1).id
  #   expect(gsj.release_day).to eq 1
  #   visit slideshow_path(gsj.bit_player_slideshow)
  #   with_scope "#group-slide-show-#{gsj.id}" do
  #     click_on "Edit"
  #   end
  #   select('Group 2', from: "Select Group")
  #   fill_in('Select number of days into intervention to make available', with: 2)
  #   click_on 'Update'
  #   # gsj = GroupSlideshowJoin.find(group_slideshow_joins(:group_slideshow_join1).id)
  #   gsj.reload
  #   expect(gsj.group_id).to eq groups(:group2).id
  #   expect(gsj.release_day).to eq 2
  # end

  it "validation that the same slideshow can't be assigned more than once" do
    visit slideshow_path(group_slideshow_joins(:group_slideshow_join1).bit_player_slideshow)
    click_on "Assign"
    select('Group 1', from: "Select Group")
    fill_in('Select number of days into intervention to make available', with: 1)
    click_on('Save')
    expect(page).to have_text("Unable to assign slideshow")
    expect(page).to have_text("Release day This slideshow has already been assigned and set to be released on this day to this group.")
  end

  it 'can unassign slideshow to group' do
    gsj = group_slideshow_joins(:group_slideshow_join1)
    expect(GroupSlideshowJoin.where(id: gsj.id).count).not_to eq 0
    visit slideshow_path(gsj.bit_player_slideshow)
    with_scope "#group-slide-show-#{gsj.id}" do
      click_on "Remove"
    end
    expect(GroupSlideshowJoin.where(id: gsj.id).count).to eq 0
  end

end