require 'spec_helper'

describe Navigator do
  it 'should render the content from the current provider' do
    nav = Navigator.new({})
    expect(nav.render_current_content(nil)).to eq('Null content provider')
  end
end
