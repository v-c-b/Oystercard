require 'journey'

describe Journey do
  let(:station) {double :station }
  let(:station2) {double :station }

  describe 'journey start' do
    it 'stores the entry_station' do
    j = Journey.new(station)
  expect(j.journey[:entry_station]).to eq(station)
  end
    it "returns PENALTY_FARE if journey only exit station" do
      j = Journey.new(nil, station)
      expect(j.fare).to eq(Journey::PENALTY_FARE)
    end
    it "returns 1 if journey contains entry and exit station" do
      j = Journey.new(station2, station, true)
      expect(j.fare).to_not eq(Journey::PENALTY_FARE)
    end

end

end
