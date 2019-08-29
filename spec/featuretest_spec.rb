require "journey"
require "oystercard"
require "station"

describe "Touchout without touching in" do
  it "charges PENALTY_FARE" do
    card = Oystercard.new
    station1 = Station.new
    station2 = Station.new("Picadilly",2)
    card.top_up(10)
    expect {card.touch_out(station1)}.to change{card.balance}.by -Journey::PENALTY_FARE
  end
end

describe "Touchout without touching in but with one complete journey before" do
  it "charges PENALTY_FARE" do
    card = Oystercard.new
    station1 = Station.new
    station2 = Station.new("Picadilly",2)
    card.top_up(10)
    card.touch_in(station1)
    card.touch_out(station2)
    expect {card.touch_out(station1)}.to change{card.balance}.by -Journey::PENALTY_FARE
  end
end




describe "Touching in twice without toching out in between" do
  it "charges PENALTY_FARE" do
    card = Oystercard.new
    station1 = Station.new
    station2 = Station.new("Picadilly",2)
    card.top_up(10)
    card.touch_in(station1)
    expect {card.touch_in(station1)}.to change{card.balance}.by -Journey::PENALTY_FARE
  end
end


describe "Touching in and out" do
  it "charges 1" do
    card = Oystercard.new
    station1 = Station.new
    station2 = Station.new("Picadilly",2)
    card.top_up(10)
    card.touch_in(station1)
    expect {card.touch_out(station2)}.to change{card.balance}.by -1
  end

end
