require 'spec_helper'

describe 'activity tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  describe 'with a slideshow' do
    it 'should allow slideshow navigation' do
      sign_in_participant participants(:participant1)
      visit '/activity_tracker'
      find('.next-button').click

      expect(page).to have_text(slides(:slide2).body)
    end
  end
end
