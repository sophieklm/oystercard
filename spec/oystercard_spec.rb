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
      expect{subject.top_up(91)}.to raise_error "Maximum card balance £90.00"
    end

  end

end
