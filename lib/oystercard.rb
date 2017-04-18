class Oystercard

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(value)
    fail "Maximum card balance £90.00" if (@balance + value) > 90
    @balance += value
  end

end
