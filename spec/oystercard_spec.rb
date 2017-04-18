require 'oystercard'

describe Oystercard do

  before(:each) do
    @station = double(:station)
  end

  min_fare = Oystercard::MIN_FARE
  max_balance = Oystercard::MAX_BALANCE

  describe 'balance' do
    it 'sets a default balance to 0' do
      expect(subject.balance).to eq 0
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
    it 'changes in_journey to true' do
      subject.top_up(min_fare)
      subject.touch_in(@station)
      expect(subject.in_journey?).to be true
    end
    it 'raises an error if balance less than minumum fare' do
      expect{subject.touch_in(@station)}.to raise_error "Insufficient funds, you need to have the minimum amount (£#{min_fare}) for a single journey."
    end
    it 'remembers the entry station after touch in' do
      subject.top_up(min_fare)
      subject.touch_in(@station)
      expect(subject.entry_station).to eq @station
    end
  end

  describe '#touch_out' do
    it 'changes in_journey to false' do
      subject.touch_out
      expect(subject.in_journey?).to be false
    end
    it 'changes the balance when touching out' do
      expect{subject.touch_out}.to change{subject.balance}.by(-min_fare)
    end
    it 'forgets the entry station on touch out' do
      subject.top_up(min_fare)
      subject.touch_in(@station)
      subject.touch_out
      expect(subject.entry_station).to be_nil
    end
  end
end
