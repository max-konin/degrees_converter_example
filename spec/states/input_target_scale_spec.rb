require_relative './../../lib/states/input_target_scale.rb'
require_relative './../../lib/states/input_value.rb'
require_relative './../../lib/io_adapter.rb'

describe States::InputTargetScale do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  describe '#render' do
    it 'renders correct sentence' do
      subject.render
      expect(io_mock).to have_received(:write).with(
        'Input the target scale (C, F, K)'
      )
    end
  end
  
  describe '#next' do
    subject { described_class.new(source_scale: 'K').next }
    before { allow(io_mock).to receive(:read).and_return(value) }

    context 'when the user inputs correct value and !== source' do
      let(:value) { 'C' }
      it { is_expected.to be_a(States::InputValue) }
    end
    context 'when the user inputs correct value and == source' do
      let(:value) { 'K' }
      it { is_expected.to be_a(States::InputTargetScale) }
      it 'renders error' do
        subject
        expect(io_mock).to have_received(:write).with(
          'The target scale must not equal the source scale'
        )
      end
    end
    context 'when the user inputs another value' do
      let(:value) { 'fake' }
      it { is_expected.to be_a(States::InputTargetScale) }
      it 'renders error' do
        subject
        expect(io_mock).to have_received(:write).with(
          'The target scale must be "C", "F", or "K"'
        )
      end
    end
  end
end
