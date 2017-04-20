require 'journey'
require 'oystercard'

describe Journey do
  let(:bank) {double :station}
  let(:vauxhall) {double :station}
  subject{described_class.new(bank)}

  it 'has a penalty fare constant' do
    expect(Journey::PENALTY_FARE).to eq 6
  end

  it 'has a minimum fare constant' do
    expect(Journey::MIN_FARE).to eq 2
  end

  describe '#initialize' do
    it 'has a entry station' do
      expect(subject).to respond_to(:entry_station)
    end
    it 'has an exit station' do
      expect(subject).to respond_to(:exit_station)
    end
  end

  describe '#start_journey' do
    it 'sets #entry_station to parameter passed at initialization' do
      expect(subject.entry_station).to eq bank
    end
  end

  describe '#end_journey' do
   it 'sets #exit_station to parameter it is passed' do
      subject.end_journey(vauxhall)
      expect(subject.exit_station).to eq vauxhall
    end
  end

  describe '#journey_complete?' do
    it 'checks values of entry station' do
      expect(subject).to receive(:entry_station)
      subject.journey_complete?
    end

    it 'checks values of exit station' do
      expect(subject).to receive(:exit_station)
      subject.journey_complete?
    end
  end

  describe '#calculate_fare' do
    it 'returns the minimum fare' do
      oystercard = class_double(Oystercard).
        as_stubbed_const(:transfer_nested_constants => true)
      expect(subject.calculate_fare).to eq Oystercard::MIN_FARE
    end
  end

end
