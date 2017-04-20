# coding: utf-8
require 'oystercard'

describe Oystercard do

  let(:entry_station) {double :station}
  let(:exit_station) {double :station}
  let(:journey) {{entry_station: entry_station, exit_station: exit_station}}

  min_fare = Oystercard::MIN_FARE
  max_balance = Oystercard::MAX_BALANCE

  context 'card has just been initialized' do

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

    describe '#in_journey' do
      it 'shows if the card is in a journey' do
        expect(subject.in_journey?).to be false
      end
    end

  end

  describe '#touch_in' do
    context 'balance is less than minimum fare' do
      it 'raises an error' do
        expect{subject.touch_in(entry_station)}.to raise_error "Insufficient funds, you need to have the minimum amount (£#{min_fare}) for a single journey."
      end
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

  context 'card is topped up and touched in' do
    before(:example) do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
    end

    describe '#touch_in' do
      it 'changes in_journey to true' do
        expect(subject.in_journey?).to be true
      end
      it 'remembers the entry station after touch in' do
        expect(subject.current_journey.entry_station).to eq entry_station
      end
      it 'creates a new journey' do
        expect(subject.current_journey).to be_instance_of(Journey)
      end
    end

    describe '#touch_out' do
      it 'changes the balance when touching out' do
        expect{subject.touch_out(exit_station)}.to change{subject.balance}.by(-min_fare)
      end
      it 'change exit station for journey' do
        subject.touch_out(exit_station)
        expect(subject.current_journey.exit_station).to eq(exit_station)
      end
    end
  end

  context 'card is topped up, touched in, and touched back out' do
    before(:example) do
      subject.top_up(min_fare)
      subject.touch_in(entry_station)
      subject.touch_out(exit_station)
    end

    describe '#touch_out' do
      it 'changes in_journey to false' do
        expect(subject.in_journey?).to be false
      end
      it 'stores journeys' do
        expect(subject.journeys).to include subject.current_journey
      end
    end
  end

end
