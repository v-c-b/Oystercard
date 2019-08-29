require_relative "journey"
require_relative "station"
require_relative 'journeylog'

class Oystercard
  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = -3 # tests cannot handle posirive limits, needs to be 0 or negative
  MINIMUM_AMOUNT_TO_TOUCH_IN = 1

  attr_reader :balance, :entry_station, :journeys

  def initialize
    @balance = 0
    @log = JourneyLog.new # change to array?
  end

  def top_up(amount)
    over_limit?(amount)
    @balance += amount
  end

  def touch_in(station)
    sufficient_balance_to_touch_in
    deduct(@log.fare) unless @log.empty? || !@log.in_journey?
    @log.start(station)
  end

  def touch_out(station)
    @log.create_missing_journey(station)
    @log.finish(station)
    deduct(@log.fare)
  end

  def history
    @log.log
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
