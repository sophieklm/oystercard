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
    subject { Station }

    it 'checks the filename provided exists' do
      expect(File).to receive(:exists?).with("stations.csv")
      subject.load_stations("stations.csv")
    end

    before(:example) do
      allow(File).to receive(:exists?).with("file").and_return(true)
      allow(File).to receive(:exists?).with("stations.csv").and_return(true)
    end

    it 'loads a list of stations from csv' do
      expect(File).to receive(:open).with("stations.csv", {:universal_newline=>false}).and_return("stations.csv")
      subject.load_stations("stations.csv")
    end

    it 'loads first line from csv into @@stations' do
      subject.load_stations("stations.csv")
      expect(subject.stations[0].name).to eq "Arsenal"
    end

  end


end
