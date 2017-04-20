# coding: utf-8
class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 2

  attr_reader :balance, :journeys, :current_journey

  def initialize
    @balance = 0
    @journeys = []
  end

  def in_journey?
    !!@current_journey && !(@current_journey.journey_complete?)
  end

  def top_up(value)
    fail "Maximum card balance £#{MAX_BALANCE}" if (@balance + value) > MAX_BALANCE
    @balance += value
  end

  def touch_in(station)
    fail "Insufficient funds, you need to have the minimum amount (£#{MIN_FARE}) for a single journey." if @balance < MIN_FARE
    @in_journey = true
    @current_journey = Journey.new(station)
  end

  def touch_out(exit_station)
    fail "Touch in before touching out." unless in_journey?
    deduct(MIN_FARE)
    @current_journey.end_journey(exit_station)
    store_journey
  end

  private

  def deduct(value)
    @balance -= value
  end

  def store_journey
    self.journeys << @current_journey
  end

  def reset_current_journey
    @current_journey = nil
  end

end
