class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = -3 # tests cannot handle posirive limits, needs to be 0 or negative
  MINIMUM_AMOUNT_TO_TOUCH_IN = 1

  attr_reader :balance, :entry_station, :journey

  def initialize
    @balance = 0
    @journey = {} # change to array?
  end

  def top_up(amount)
    over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    sufficient_balance_to_touch_in # move - constant might be better defined in journey?
    deduct(MINIMUM_AMOUNT_TO_TOUCH_IN) #move?
    @entry_station = station #move?
  end

  def touch_out(station)
    @journey.store(@entry_station, station) #change?
    @entry_station = nil #nmove?
  end

  def in_journey? #move
    if @entry_station != nil then
      return true
    else false
    end
  end

  private

  def over_limit?(amount)
    raise "You have reached your top-up limit of #{MAXIMUM_BALANCE}." if @balance + amount > MAXIMUM_BALANCE
  end

  def below_min_limit?(amount)
    raise "Failed - you attempted to go below limit of #{MINIMUM_BALANCE}." if @balance - amount < MINIMUM_BALANCE
  end

  def sufficient_balance_to_touch_in
    raise "Failed - you do not have minimunm balance of #{MINIMUM_AMOUNT_TO_TOUCH_IN}." if @balance < MINIMUM_AMOUNT_TO_TOUCH_IN
  end

  def deduct(amount)
    below_min_limit?(amount)
    @balance -= amount
  end
end
