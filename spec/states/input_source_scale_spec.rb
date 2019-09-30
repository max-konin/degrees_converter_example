require_relative './../../lib/states/input_source_scale.rb'
require_relative './../../lib/states/input_target_scale.rb'
require_relative './../../lib/io_adapter.rb'

describe States::InputSourceScale do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  describe '#render' do
    it 'renders correct sentence' do
      subject.render
      expect(io_mock).to have_received(:write).with(
        'Input the source scale (C, F, K)'
      )
    end
  end
  
  describe '#next' do
    subject { described_class.new.next }
    before { allow(io_mock).to receive(:read).and_return(value) }

    context 'when the user inputs "C"' do
      let(:value) { 'C' }
      it { is_expected.to be_a(States::InputTargetScale) }
    end
    context 'when the user inputs "K"' do
      let(:value) { 'K' }
      it { is_expected.to be_a(States::InputTargetScale) }
    end
    context 'when the user inputs "F"' do
      let(:value) { 'F' }
      it { is_expected.to be_a(States::InputTargetScale) }
    end
    context 'when the user inputs another value' do
      let(:value) { 'fake' }
      it { is_expected.to be_a(States::InputSourceScale) }
      it 'renders error' do
        subject
        expect(io_mock).to have_received(:write).with(
          'The source scale must be "C", "F", or "K"'
        )
      end
    end
  end
end
