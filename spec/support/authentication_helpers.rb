module AuthenticationHelpers
  def sign_in_participant(participant)
    visit new_participant_session_path
    fill_in "Email", with: participant.email
    fill_in "Password", with: "secrets!"
    click_on "Sign in"
  end

  def sign_in_user(user)
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "secrets!"
    click_on "Sign in"
  end
end
