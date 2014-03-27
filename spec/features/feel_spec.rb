require "spec_helper"

describe "Slides" do
  fixtures :participants, :"bit_player/slideshows", :"bit_player/content_modules", :"bit_player/content_providers"

  let(:participant) { participants(:participant1) }

  before do
    sign_in_participant participant
    visit "/navigator/contexts/feeling_tracker"
  end

  it "User can rate their Mood" do
    click_on "#1 Tracking Your Mood"
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).to be_nil
    click_on "Continue" # Rate mood
    expect(page).to have_text("Mood saved")
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).not_to be_nil
    expect(mood.rating).to eq 5
    expect(mood.mood_value).to eq "Neither"
  end

  it "User can set their Emotion", :js do
    click_on "#2 Monitoring Your Emotions"
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).to be_nil
    click_on "Continue" # This rates the mood @ 5
    expect(page).to have_text("Mood saved")
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).not_to be_nil
    expect(mood.rating).to eq 5
    expect(mood.mood_value).to eq "Neither"
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).to be_nil
    with_scope "#edit-emotion-1" do
      check "Sympathy"
    end
    click_on "Save Emotions"
    expect(page).to have_text("Emotion saved")
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).not_to be_nil
    expect(emotion.valence).to eq 0
    expect(emotion.intensity).to eq 5
    expect(emotion.intensity_value).to eq "Average"
    expect(emotion.rating).to eq 5
    expect(emotion.rating_value).to eq "Neither"
    expect(page).to have_text "Your Recent Emotions"
    expect(page).to have_text "When Recorded"
    expect(page).to have_text "less than a minute ago"
    expect(page).to have_text "Rating"
    expect(page).to have_text "5"
    expect(page).to have_text "Intensity"
    expect(page).to have_text "5"
  end

  it "User can set their Emotion to be 'Good' with 'High' intensity", :js do
    click_on "#2 Monitoring Your Emotions"
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).to be_nil
    page.execute_script(%Q($('#mood_rating').attr('value', "8"))) # Rate mood
    click_on "Continue"
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).not_to be_nil
    expect(mood.rating).to eq 8
    expect(mood.mood_value).to eq "Good"
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).to be_nil
    with_scope "#edit-emotion-1" do
      check "Relief"
      page.execute_script(%Q($('#emotion-intensity-1').attr('value', "9"))) # Rate Emotion's Intensity
    end
    click_on "Save Emotions"
    expect(page).to have_text("Emotion saved")
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).not_to be_nil
    expect(emotion.valence).to eq 1
    expect(emotion.intensity).to eq 9
    expect(emotion.intensity_value).to eq "High"
    expect(emotion.rating).to eq 8
    expect(emotion.rating_value).to eq "Good"
    expect(page).to have_text "8"
    expect(page).to have_text "9"
  end

  it "User can set their Emotion to be 'Bad' with 'Low' intensity", :js do
    click_on "#2 Monitoring Your Emotions"
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).to be_nil
    page.execute_script(%Q($('#mood_rating').attr('value', "2"))) # Rate mood
    click_on "Continue"
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).not_to be_nil
    expect(mood.rating).to eq 2
    expect(mood.mood_value).to eq "Bad"
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).to be_nil
    with_scope "#edit-emotion-1" do
      check "Nervousness"
      page.execute_script(%Q($('#emotion-intensity-1').attr('value', "3"))) # Rate Emotion's Intensity
    end
    click_on "Save Emotions"
    expect(page).to have_text("Emotion saved")
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).not_to be_nil
    expect(emotion.valence).to eq(-1)
    expect(emotion.intensity).to eq 3
    expect(emotion.intensity_value).to eq "Low"
    expect(emotion.rating).to eq 2
    expect(emotion.rating_value).to eq "Bad"
    expect(page).to have_text "2"
    expect(page).to have_text "3"
  end

end