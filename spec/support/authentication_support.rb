module AuthenticationHelper
  def sign_in_participant(participant)
    visit new_participant_session_path
    fill_in 'Email', with: participant.email
    fill_in 'Password', with: 'secrets!'
    click_on 'Sign in'
  end
end
