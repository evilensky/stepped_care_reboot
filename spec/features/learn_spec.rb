require 'spec_helper'

describe 'learn' do
  fixtures(
    :participants
  )

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/library'
  end

  it 'should allow a participant to select what to learn' do
    expect(page).to have_link('Lessons')
    expect(page).to have_link('Videos')
  end

  it 'should be able to view assigned slideshow'

  # USERS
  it 'should be able to assign slideshow to group'
  it 'should be able to unassign slideshow to group'

end
