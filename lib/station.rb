require 'csv'

class Station

  @@stations = []
  attr_reader :name, :zone

  def self.load_stations(file)
    File.exists?(file)
    CSV.foreach(file) do |row|
      @@stations << Station.new({name: row[0], zone: row[1]})
    end
  end

  def initialize(hash)
    @name = hash[:name]
    @zone = hash[:zone]
  end

  def self.stations
    @@stations
  end

end
