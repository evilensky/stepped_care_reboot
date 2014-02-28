require 'spec_helper'

describe 'home context' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  it 'should have the correct content' do
    sign_in_participant participants(:participant1)
    visit '/'

    expect(page).to have_text("It's simple")

    find('.next-button').click

    expect(page).to have_text("Log in once a day")

    find('.next-button').click

    expect(page).to have_text("Come back every day")
  end
end
