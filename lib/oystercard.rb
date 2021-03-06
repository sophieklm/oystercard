# coding: utf-8
require_relative 'journey'

class Oystercard

  MAX_BALANCE = 90
  MIN_FARE = 2
  PENALTY_FARE = 6

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
    penalty_process if in_journey?
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

  attr_writer :current_journey

  def deduct(value)
    @balance -= value
  end

  def store_journey
    self.journeys << @current_journey
  end

  def reset_current_journey
    self.current_journey = nil
  end

  def penalty_process
    mark_journey_as_penalized
    store_journey
    reset_current_journey
    deduct(PENALTY_FARE)
  end

  def mark_journey_as_penalized
    current_journey.end_journey(:penalty_fare)
  end
    

end
