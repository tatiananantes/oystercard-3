class Oystercard
  attr_reader :balance , :minimum_fare, :entry_station, :exit_station, :journeys

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @minimum_fare = 1
    @journeys = {}
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, you can not add more money to your Oystercard!" if balance + amount > CARD_LIMIT
    @balance += amount 
  end



  def touch_in(station)
    fail "No funds available" if @balance < @minimum_fare
    # @in_journey = true
      @entry_station = station
      @journeys[:start] = station
  end

  def touch_out(station)
    deduct(MINIMUM_FARE)
    @exit_station = station
    @entry_station = nil
    @journeys[:end] = station
  end

  def in_journey?
    !!entry_station
  end

  private
  def deduct(fare)
    @balance -= fare
  end


end
