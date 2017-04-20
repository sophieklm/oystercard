require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}

  min_fare = Oystercard::MIN_FARE
  max_balance = Oystercard::MAX_BALANCE

  describe '#balance' do
    it 'sets a default balance to 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe '#journeys' do
    it 'has an empty list of journeys by default' do
      expect(subject.journeys).to be_empty
    end
  end

  describe '#top_up' do
    it 'increases balance by argument value' do
      expect{subject.top_up(1)}.to change{subject.balance}.by 1
    end
    it 'raises an error when top up limit exceeded' do
      expect{subject.top_up(max_balance + 1)}.to raise_error "Maximum card balance £#{max_balance}"
    end
  end

  describe '#in_journey' do
    it 'shows if the card is in a journey' do
      expect(subject.in_journey?).to be false
    end
  end

  describe '#touch_in' do
    it 'raises an error if balance less than minumum fare' do
      expect{subject.touch_in(entry_station)}.to raise_error "Insufficient funds, you need to have the minimum amount (£#{min_fare}) for a single journey."
    end
    it 'changes in_journey to true' do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      expect(subject.in_journey?).to be true
    end
    it 'remembers the entry station after touch in' do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      expect(subject.entry_station).to eq entry_station
    end
  end

  describe '#touch_out' do
    it 'changes the balance when touching out' do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-min_fare)
    end
    before do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end
    it 'changes in_journey to false' do
      expect(subject.in_journey?).to be false
    end
    it 'forgets the entry station on touch out' do
      expect(subject.entry_station).to be_nil
    end
    it 'stores journeys' do
      expect(subject.journeys).to include journey
    end
  end
end
