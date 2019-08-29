class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = -3 # tests cannot handle posirive limits, needs to be 0 or negative
  MINIMUM_AMOUNT_TO_TOUCH_IN = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @journeys = [] # change to array?
  end

  def top_up(amount)
    over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    sufficient_balance_to_touch_in
    deduct(@journeys[-1].fare) unless @journeys.empty?
    @journeys << Journey.new(station)
    @entry_station = station
  end

  def touch_out(station)
    @journeys << Journey.new(nil, station, true) if @journeys.empty?
    @journeys << Journey.new(nil, station, true) if @journeys[-1].journey[:complete] == true
    @journeys[-1].end_trip(station)
    @entry_station = nil
    deduct(@journeys[-1].fare)
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
