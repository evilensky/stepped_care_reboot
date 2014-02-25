require 'spec_helper'

describe Navigator do
  let(:view_context) { double('view context', current_participant: double('participant')) }

  it 'should render the content from the current provider' do
    nav = Navigator.new({})
    expect(nav.render_current_content(view_context)).to eq('Null content provider')
  end
end
