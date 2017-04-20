class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 2

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @entry_station
    @journeys = []
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

  def touch_out(exit_station)
    fail "Touch in before touching out." unless in_journey?
    deduct(MIN_FARE)
    @in_journey = false
    store_journey(@entry_station,exit_station)
    @entry_station = nil
  end

  def store_journey(entry_station, exit_station)
    journey = {}
    journey[:entry_station] = entry_station
    journey[:exit_station] = exit_station
    @journeys << journey
  end

  private

  def deduct(value)
    @balance -= value
  end

end
