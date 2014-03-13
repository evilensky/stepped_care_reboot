require 'spec_helper'

describe 'coach messages' do
  fixtures :users, :participants, :coach_assignments

  before do
    sign_in_user users(:user1)
    visit '/coach/messages'
  end

  it 'should allow a coach to compose and submit a new message' do
    click_on('Compose')
    select('participant1@example.com', from: 'To')
    fill_in('Subject', with: 'some new message')
    fill_in('Message', with: 'some body')
    click_on('Send')

    expect(page).to have_text('Message saved')
  end
end
