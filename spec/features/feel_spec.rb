require 'spec_helper'

describe 'Slides' do
  fixtures :participants, :'bit_player/slideshows', :'bit_player/content_modules'#, :'bit_player/content_providers'

  let(:participant) { participants(:participant1) }

  before do
    sign_in_participant participant
    visit '/navigator/contexts/feeling_tracker'
  end

  it 'User can rate their Mood' do
    click_on "#1 Tracking Your Mood"
    click_on "Continue" # Intro
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).to be_nil
    click_on "Continue" # Rate mood 
    expect(page).to have_text("Mood saved")
    mood = Mood.find_by_participant_id(participant.id)
    expect(mood).not_to be_nil
    expect(mood.rating).to eq 0
    expect(mood.mood_value).to eq "Neither"
  end

  it 'User can classify their Emotion' do
    click_on "#1 Tracking Your Mood"
    click_on "Continue" # Intro
    click_on "Continue" # Rate mood 
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).to be_nil
    click_on "Continue" # Classify Emotion 
    expect(page).to have_text("Emotion saved")
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion).not_to be_nil
    expect(emotion.activation_level).to eq 0
    expect(emotion.activation_level_value).to eq "Neutral"
    expect(emotion.rating).to eq 0
    expect(emotion.rating_value).to eq "Neither"
    select("Calm", from: "Emotions") # Further Classify Emotion
    click_on "Continue"
    emotion = Emotion.find_by_participant_id(participant.id)
    expect(emotion.name).to eq "Calm"
    expect(emotion.intensity).to eq 5
    expect(emotion.intensity_value).to eq "Average"
  end

end
