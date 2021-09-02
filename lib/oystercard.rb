class Oystercard
  MAXIMUM_AMOUNT = 90
  MINIMUM_AMOUNT = 1
  MINIMUM_CHARGE = 1

  attr_reader :balance, :entry_station, :exit_station, :journey

  def initialize 
    @balance = 0
    @entry_station = nil
    @journey = []
  end

  def top_up(value)
    raise "Balance cannot exceed #{MAXIMUM_AMOUNT}" if (@balance + value) > MAXIMUM_AMOUNT
    @balance += value
  end

  def touch_in(station)
    raise "Cannot touch in: balance is below #{MINIMUM_AMOUNT}" if @balance < MINIMUM_AMOUNT  
    @entry_station = station
  end

  def touch_out(station)
    deduct(MINIMUM_CHARGE)
    @entry_station = nil
    @exit_station = station
  end

  def in_journey
    !!entry_station
  end 

  # def journey 
  #   @journey 
  # end 

  # def entry_station
  #   @entry_station
  # end 

  #  def exit_station
  #    @exit_station
  #  end 

  private

  def deduct(value)
    @balance -= value
  end
end
