require 'oystercard'

describe Oystercard do
  describe 'balance' do
    it 'sets a default balance to 0' do
      expect(subject.balance).to eq 0
    end
  end

  describe 'top_up' do
    it {is_expected.to respond_to(:top_up).with(1).argument}
    it 'increases balance by argument value' do
      expect{subject.top_up(1)}.to change{subject.balance}.by 1
    end

    it 'raises an error when top up limit exceeded' do
      max_balance = Oystercard::MAX_BALANCE
      expect{subject.top_up(max_balance + 1)}.to raise_error "Maximum card balance £#{max_balance}"
    end
  end

  describe '#deduct' do
    it {is_expected.to respond_to(:deduct).with(1).argument}
    it 'reduces balance by value argument' do
      subject.top_up(1)
      expect{subject.deduct(1)}.to change{subject.balance}.by -1
    end
  end

  describe '#in_journey' do
    it 'shows if the card is in a journey' do
      expect(subject.in_journey).to be false
    end
  end

  describe '#touch_in' do
    it 'changes in_journey to true' do
      subject.touch_in
      expect(subject.in_journey).to be true
    end
  end

  describe '#touch_out' do
    it 'changes in_journey to false' do
      subject.touch_out
      expect(subject.in_journey).to be false
    end
  end


end
