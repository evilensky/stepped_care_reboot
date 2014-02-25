require 'spec_helper'

describe 'activity tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  describe 'with multiple providers' do
    it 'should allow navigation' do
      sign_in_participant participants(:participant1)
      visit '/navigator/contexts/activity_tracker'
      find('.next-button').click

      expect(page).to have_text(slides(:slide2).body)

      find('.next-button').click
    end
  end
end
