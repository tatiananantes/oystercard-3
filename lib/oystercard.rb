class Oystercard
  attr_reader :balance , :minimum_fare

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @minimum_fare = 1
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, you can not add more money to your oystercard!" if @balance + amount > CARD_LIMIT
    @balance += amount 
  end



  def touch_in
    fail "No funds available" if @balance < @minimum_fare
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
  end

private
def deduct(fare)
  @balance -= fare
end


end
