require 'csv'

class Station

  attr_reader :name, :zone

  def self.load_stations(file)
    File.exists?(file)
  end

  def initialize(hash)
    @name = hash[:name]
    @zone = hash[:zone]
  end

end
