require_relative './../../lib/states/calculation.rb'
require_relative './../../lib/states/input_value.rb'
require_relative './../../lib/io_adapter.rb'

describe States::InputValue do
  let(:io_mock) { double 'IOAdapter' }
  before do
    allow(IOAdapter).to receive(:instance).and_return(io_mock)
    allow(io_mock).to receive(:write)
  end

  describe '#render' do
    it 'renders correct sentence' do
      subject.render
      expect(io_mock).to have_received(:write).with(
        'Input a value'
      )
    end
  end
  
  describe '#next' do
    subject { described_class.new(source_scale: 'K').next }
    before { allow(io_mock).to receive(:read).and_return(value) }

    context 'when inputed value is a number' do
      let(:value) { '11' }
      it { is_expected.to be_a(States::Calculation) }
    end
    context 'when inputed value is not a number' do
      let(:value) { 'fake' }
      it { is_expected.to be_a(States::InputValue) }
      it 'renders error' do
        subject
        expect(io_mock).to have_received(:write).with(
          'The value must be a number'
        )
      end
    end
  end
end
