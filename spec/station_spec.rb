require 'station'

describe Station do
  subject{described_class.new(name: "Station", zone: 1)}
  it 'has a name' do
    expect(subject.name).to eq("Station")
  end
  it 'has a zone' do
    expect(subject.zone).to eq(1)
  end

  describe '.load_stations' do
    file = CSV.generate do |csv|
      csv << ["Trafalgar Square", 1]
      csv << ["Edgware", 3]
    end

    it 'checks existence of file' do
      expect(File).to receive(:exists?).with("file")
    end

    xit 'loads a list of stations from csv' do
      expect(File).to receive(:open).with("file", "r").and_return(file)
      Station.load_stations(file)
    end
  end


end
