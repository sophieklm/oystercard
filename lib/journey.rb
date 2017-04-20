require 'oystercard'

class Journey

  attr_reader :entry_station, :exit_station

  def initialize(station)
    start_journey(station)
  end

  def start_journey(station)
    self.entry_station = station
  end

  def end_journey(station)
    self.exit_station = station
  end

  def calculate_fare
    Oystercard::MIN_FARE
  end

  def journey_complete?
    entry_station && exit_station
  end

  private

  attr_writer :entry_station, :exit_station

end
