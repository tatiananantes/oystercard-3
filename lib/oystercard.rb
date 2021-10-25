class Oystercard
  attr_reader :balance
  CARD_LIMIT = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    fail "The limit is #{CARD_LIMIT}, can not add more money on your oystercard!" if exceeds_limit?(amount)
    @balance += amount 
  end

  private

  def exceeds_limit?(amount)
    @balance + amount > CARD_LIMIT
  end
end