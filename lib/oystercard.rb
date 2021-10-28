class Oystercard
  attr_reader :balance , :minimum_fare, :entry_station

  CARD_LIMIT = 90
  MINIMUM_FARE = 1

  def initialize
    @balance = 0
    @in_journey = false
    @minimum_fare = 1
    @entry_station = nil  # Not sure if needed


  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, you can not add more money to your Oystercard!" if balance + amount > CARD_LIMIT
    @balance += amount 
  end



  def touch_in(station)
    fail "No funds available" if @balance < @minimum_fare
    p @in_journey = true
     @entry_station = station  # if this in, we do not receive error 1 on rspec.  However, this
    # is not showing on walkthrough code.
    # different ways of listing station, :entry_station, etc. tried but getting
    # 2) Oystercard#touch_out forgets entry_station on check out
    #      Failure/Error: expect {card.touch_out}.to change {:station}.to nil
    #        expected `:station` to have changed to nil, but did not change
    #      # ./spec/oystercard_spec.rb:75:in `block (3 levels) in <top (required)>'
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
    @entry_station = nil

  end

  def in_journey?
    @in_journey
  end

  private
  def deduct(fare)
    @balance -= fare
  end


end
