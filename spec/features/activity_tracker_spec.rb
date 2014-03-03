require 'spec_helper'

describe 'activity tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/activity_tracker'
  end

  it 'should implement #1 Awareness' do
    expect(page).to have_text(content_modules(:do_awareness).title)

    click_on content_modules(:do_awareness).title

    expect(page).to have_text(slides(:do_awareness_intro1).body)

    find('.next-button').click

    expect(page).to have_text("OK, let's talk about yesterday.")

    find('input[type="submit"]').click

    expect(page).to have_text("Let’s break it down hour by hour...")

    fill_in('What did you do from 12am to 1am?', with: 'ate cheeseburgers')
    fill_in('How much pleasure did you get from doing this?', with: 9)
    fill_in('How much did doing this give you a sense of accomplishment?', with: 4)

    find('input[type="submit"]').click

    expect(page).to have_text("Take a look--does this all seem right?")
    expect(page).to have_text("ate cheeseburgers")

    find('.next-button').click

    expect(page).to have_text("Things you found fun.")
    expect(page).to have_text("ate cheeseburgers")

    find('.next-button').click

    expect(page).to have_text("Things that make you feel like you've accomplished something.")
    expect(page).not_to have_text("ate cheeseburgers")

    find('.next-button').click

    expect(page).to have_text("#2 Planning")
  end

  it 'should implement #2 Planning' do
    click_on content_modules(:do_planning).title

    expect(page).to have_text(slides(:do_planning_intro1).body)

    find('.next-button').click

    expect(page).to have_text("We want you to plan a few fun things.")
    # TODO: failing, needs review
    #expect(page).to have_text("Loving")

    #find('input[type="submit"]').click

    #expect(page).to have_text("OK, you also said certain things were important to you.")
    #expect(page).to have_text("Parkour")

    #find('input[type="submit"]').click

    #expect(page).to have_text("OK... the most important thing")

    #find('.next-button').click

    #fill_in('OK, what’s something fun that you can do this week?', with: 'go paintballing')
    #fill_in('And, something else you can do that gives you a sense of accomplishment?', with: 'take out the trash')

    #find('input[type="submit"]').click

    #expect(page).to have_text("Alright--we've picked a few important and a few fun things.")

    #find('input[type="submit"]').click
    #find('input[type="submit"]').click
    #find('input[type="submit"]').click
    #find('input[type="submit"]').click

    #expect(page).to have_text("#3 Doing")
  end
end
