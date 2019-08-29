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
