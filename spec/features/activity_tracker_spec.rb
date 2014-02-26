require 'spec_helper'

describe 'activity tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  describe 'with multiple modules and multiple providers' do
    before do
      sign_in_participant participants(:participant1)
      visit '/navigator/contexts/activity_tracker'
    end

    it 'should list the modules on the landing page' do
      expect(page).to have_text(content_modules(:activity_tracker_module2).title)
    end

    it 'should allow navigation through the modules' do
      click_on content_modules(:activity_tracker_module2).title

      expect(page).to have_text(slides(:do_awareness_intro1).body)

      find('.next-button').click

      expect(page).to have_text("OK, let's talk about yesterday.")
    end
  end
end
