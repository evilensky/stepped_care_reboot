require 'spec_helper'

describe 'activity tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  describe 'with a module and multiple providers' do
    it 'should list the module on the landing page' do
      sign_in_participant participants(:participant1)
      visit '/navigator/contexts/activity_tracker'

      expect(page).to have_text(content_modules(:activity_tracker_module2).title)
    end

    it 'should allow navigation within the slideshow' do
      sign_in_participant participants(:participant1)
      visit '/navigator/contexts/activity_tracker'
      click_on content_modules(:activity_tracker_module2).title
      find('.next-button').click

      expect(page).to have_text(slides(:slide2).body)

      find('.next-button').click
    end
  end
end
