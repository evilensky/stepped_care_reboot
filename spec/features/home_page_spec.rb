require 'spec_helper'

describe 'home page' do
  fixtures :participants, :slideshows, :slides

  describe 'user visits' do
    it 'should have an introduction' do
      sign_in_participant participants(:participant1)

      expect(page).to have_text(slides(:home_intro1).body)
    end
  end
end
