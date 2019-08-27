class Oystercard

  MAXIMUM_BALANCE = 90
  MINIMUM_BALANCE = -3 # tests cannot handle posirive limits, needs to be 0 or negative

  attr_reader :balance

  def initialize
    @balance = 0
  end

  def top_up(amount)
    over_limit?(amount)
    @balance += amount
  end

  def deduct(amount)
    below_min_limit?(amount)
    @balance -= amount
  end

  private

  def over_limit?(amount)
    raise "You have reached your top-up limit of #{MAXIMUM_BALANCE}." if @balance + amount > MAXIMUM_BALANCE
  end

  def below_min_limit?(amount)
    raise "Failed - you attempted to go below limit of #{MINIMUM_BALANCE}." if @balance - amount < MINIMUM_BALANCE
  end

end
