require 'station'

describe Station do
  
station = Station.new("Waterloo", 2)

  it 'has a name' do
    expect(station.name).to eq("Waterloo")
  end 

  it 'has a zone' do 
    expect(station.zone).to eq(2)
  end 
end 

