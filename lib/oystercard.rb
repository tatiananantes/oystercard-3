class Oystercard
  attr_reader :balance , :minimum_fare, :entry_station, :exit_station, :journeys, :add_journey

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @minimum_fare = 1
    @journeys = []
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, you can not add more money to your Oystercard!" if balance + amount > CARD_LIMIT
    @balance += amount 
  end

  def touch_in(entry_station)
    fail "No funds available" if @balance < @minimum_fare
    @entry_station = entry_station
    @exit_station = nil
  end

  def touch_out(exit_station)
    deduct(MINIMUM_FARE)
    @exit_station = exit_station
    add_journey
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def add_journey
    @journeys << { entry: entry_station, exit: exit_station }
  end

  def deduct(fare)
    @balance -= fare
  end

end
