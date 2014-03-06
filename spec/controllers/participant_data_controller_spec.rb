require 'spec_helper'

describe ParticipantDataController do
  describe 'POST create' do
    before do
      provider = double('provider', data_class_name: 'MyDataClass', data_attributes: [:attr1, :attr2])
      navigator = instance_double('Navigator', current_content_provider: provider)
      expect(BitPlayer::Navigator).to receive(:new) { navigator }
    end

    let(:data_record) { double('data_record', save: true) }
    let(:participant) { double('participant', build_data_record: data_record, navigation_status: nil) }

    it 'should build the desired association' do
      sign_in_participant participant
      expect(participant).to receive(:build_data_record)
        .with('my_data_classes', { 'attr1' => '1', 'attr2' => '2' })
      post :create, my_data_class: { attr1: 1, attr2: 2 }
    end
  end
end
