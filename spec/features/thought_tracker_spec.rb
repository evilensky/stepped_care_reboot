require 'spec_helper'

describe 'thought tracker' do
  fixtures :participants, :'bit_player/slideshows', :'bit_player/slides',
    :'bit_player/content_modules', :'bit_player/content_providers'

  before do
    sign_in_participant participants(:participant1)
    visit '/navigator/contexts/thought_tracker'
  end

  it 'should implement #1 Identifying' do
    click_on bit_player_content_modules(:think_identifying).title
  end
end
