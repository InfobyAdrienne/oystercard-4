require 'oystercard'

describe Oystercard do
  subject (:oystercard) { described_class.new }
  let (:entry_station) { double :station}
  let (:exit_station) { double :station}
  let(:journey){ {entry_station: entry_station, exit_station: exit_station} }


  it 'checks new card has a balance' do
    expect(oystercard.balance).to eq(0)
  end

  describe '#top_up(value)' do
    it 'adds money to card' do
      # expect(oystercard).to respond_to(:top_up).with(1).argument
      expect { oystercard.top_up(1) }.to change { oystercard.balance }.by(1)
    end 

    it 'raises an error when the card balance is above 90' do
      oystercard.top_up(90)
      expect { oystercard.top_up(1) }.to raise_error "Balance cannot exceed #{Oystercard::MAXIMUM_AMOUNT}"
    end 
  end

  describe '#in_journey?, #touch_in, #touch_out' do
    it 'responds to #in_journey?' do
      expect(oystercard.in_journey).to eq false
      # expect(oystercard).not_to be_in_journey
    end

    it '#touch_in is expected to change #in_journey to true' do
      oystercard.top_up(2)
      oystercard.touch_in(entry_station)
      expect(oystercard.in_journey).to eq true
    end

    it '#touch_out is expected to change #in_journey to false' do
      oystercard.top_up(2)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.in_journey).to eq false
    end
  
    it 'raises an error when the balance is below 1, when touch_in is called' do
      expect{ oystercard.touch_in(entry_station) }.to raise_error "Cannot touch in: balance is below #{Oystercard::MINIMUM_AMOUNT}"
    end

    it '#touch_out deducts funds from current balance' do
      oystercard.top_up(20)
      expect { oystercard.touch_out(exit_station) }.to change { oystercard.balance }.by(-Oystercard::MINIMUM_CHARGE)
    end

    it '#touch_in remembers the station' do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      expect(oystercard.entry_station).to eq(entry_station)
    end 

    it '#touch_out stores exit station' do
      oystercard.top_up(20)
      oystercard.touch_in(entry_station)
      oystercard.touch_out(exit_station)
      expect(oystercard.exit_station).to eq(exit_station)
    end

    it 'has an empty list of journeys by default' do
      expect(oystercard.journey).to be_empty
    end

    # it 'stores a journey' do
    #   oystercard.top_up(20)
    #   oystercard.touch_in(entry_station)
    #   oystercard.touch_out(exit_station)
    #   expect(oystercard.journey).to include(journey)
    # end
  end
end
