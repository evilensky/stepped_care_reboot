require 'spec_helper'

describe 'home page' do
  fixtures :participants

  describe 'user visits' do
    it 'should have an introduction' do
      sign_in_participant participants(:participant1)

      expect(page).to have_text("It's simple.")
    end
  end
end
