require 'spec_helper'

describe 'activity tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/activity_tracker'
  end

  it 'should provide the correct interactions' do
    expect(page).to have_text(content_modules(:activity_tracker_module2).title)

    click_on content_modules(:activity_tracker_module2).title

    expect(page).to have_text(slides(:do_awareness_intro1).body)

    find('.next-button').click

    expect(page).to have_text("OK, let's talk about yesterday.")

    find('input[type="submit"]').click

    expect(page).to have_text("Let’s break it down hour by hour...")
  end
end
