class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 2

  attr_reader :balance, :entry_station

  def initialize
    @balance = 0
    @entry_station
  end

  def in_journey?
    @entry_station != nil 
  end

  def top_up(value)
    fail "Maximum card balance £#{MAX_BALANCE}" if (@balance + value) > MAX_BALANCE
    @balance += value
  end

  def touch_in(station)
    fail "Insufficient funds, you need to have the minimum amount (£#{MIN_FARE}) for a single journey." if @balance < MIN_FARE
    @in_journey = true
    @entry_station = station
  end

  def touch_out
    deduct(MIN_FARE)
    @in_journey = false
    @entry_station = nil
  end

  private

  def deduct(value)
    @balance -= value
  end

end
