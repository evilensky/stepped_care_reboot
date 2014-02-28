require 'spec_helper'

describe 'home context' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  it 'should have the correct content' do
    sign_in_participant participants(:participant1)
    visit '/'

    expect(page).to have_text(slides(:home_intro1).body)

    find('.next-button').click

    expect(page).to have_text(slides(:home_intro2).body)

    find('.next-button').click

    expect(page).to have_text(slides(:home_intro3).body)
  end
end
