require 'journey'

describe Journey do
  let(:station) {double :station}
  subject{described_class.new(station)}
  it {is_expected.to respond_to(:start_journey)}
  it {is_expected.to respond_to(:end_journey)}
  it {is_expected.to respond_to(:calculate_fare)}
  it {is_expected.to respond_to(:journey_complete?)}

  describe '#initialize' do
    it 'has a entry station' do
      expect(subject).to respond_to(:entry_station)
    end
    it 'has an exit station' do
      expect(subject).to respond_to(:exit_station)
    end
  end

end
