require 'spec_helper'

describe 'learning for participants' do
  fixtures(
    :participants, :'bit_player/slideshows', :'bit_player/slides',
    :'bit_player/content_modules', :'bit_player/content_providers'
  )

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/library'
  end

  it 'will be able to select what to learn' do
    expect(page).to have_link('Lessons')
    expect(page).to have_link('Videos')
  end

  it 'will be able to view assigned slideshow' do
    click_on "Lessons"
    save_and_open_page
  end

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

  it 'will be able to assign slideshow to group' do
    group = groups(:group1)
    bit_player_slideshow = bit_player_slideshows(:rspec_slideshow)
    visit slideshow_path(bit_player_slideshow)
    expect(page).not_to have_text(group.title)
    expect(page).not_to have_text(1)
    gsj = GroupSlideshowJoin.where(group_id: group.id, bit_player_slideshow_id: bit_player_slideshow.id)
    expect(gsj.first).to be_nil
    click_on "Assign"
    select('Group1', from: "Select Group")
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

  it 'will be able to update slideshow to group' do
    # I couldn't get group_slideshow_joins.yml to create the correct group_slideshow_join -Wehrley 3/20/14
    user = users(:user1)
    group1 = groups(:group1)
    group2 = groups(:group2)
    bit_player_slideshow = bit_player_slideshows(:rspec_slideshow2)
    gsj1 = GroupSlideshowJoin.create(
      bit_player_slideshow_id: bit_player_slideshow.id,
      creator_id: user.id,
      group_id: group1.id)
    expect(gsj1.group_id).to eq group1.id
    expect(gsj1.release_day).to eq 1
    visit slideshow_path(bit_player_slideshow)
    with_scope "#group-slide-show-#{gsj1.id}" do
      click_on "Edit"
    end
    select('Group2', from: "Select Group")
    fill_in('Select number of days into intervention to make available', with: 2)
    click_on('Update')
    gsj1.reload
    expect(gsj1.group_id).to eq group2.id
    expect(gsj1.release_day).to eq 2
  end

  it "validation that the same slideshow can't be assigned more than once" do
    # I couldn't get group_slideshow_joins.yml to create the correct group_slideshow_join -Wehrley 3/20/14
    user = users(:user1)
    group = groups(:group1)
    bit_player_slideshow = bit_player_slideshows(:rspec_slideshow2)
    GroupSlideshowJoin.create(
      bit_player_slideshow_id: bit_player_slideshow.id,
      creator_id: user.id,
      group_id: group.id)
    visit slideshow_path(bit_player_slideshow)
    click_on "Assign"
    select('Group1', from: "Select Group")
    fill_in('Select number of days into intervention to make available', with: 1)
    click_on('Save')
    expect(page).to have_text("Unable to assign slideshow")
    expect(page).to have_text("Release day This slideshow has already been assigned and set to be released on this day to this group.")
  end

  it 'will be able to unassign slideshow to group' do
    # I couldn't get group_slideshow_joins.yml to create the correct group_slideshow_join -Wehrley 3/20/14
    user = users(:user1)
    group1 = groups(:group1)
    group2 = groups(:group2)
    bit_player_slideshow = bit_player_slideshows(:rspec_slideshow2)
    gsj = GroupSlideshowJoin.create(
      bit_player_slideshow_id: bit_player_slideshow.id,
      creator_id: user.id,
      group_id: group1.id)
    gsj_id = gsj.id
    expect(GroupSlideshowJoin.where(id: gsj_id).count).not_to eq 0
    visit slideshow_path(bit_player_slideshow)
    with_scope "#group-slide-show-#{gsj.id}" do
      click_on "Remove"
    end
    expect(GroupSlideshowJoin.where(id: gsj_id).count).to eq 0
  end

end