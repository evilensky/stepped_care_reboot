require 'spec_helper'

describe 'thought tracker' do
  fixtures :participants, :slideshows, :slides, :content_modules, :content_providers

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/thought_tracker'
  end

  it 'should implement #1 Identifying' do
    click_on content_modules(:think_identifying).title
  end
end
