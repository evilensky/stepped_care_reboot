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

end
