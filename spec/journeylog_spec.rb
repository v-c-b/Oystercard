require 'journeylog'

describe JourneyLog do
  let(:journey) { double(:journey) }
  let(:station) { double(:station) }
  let(:jl) { JourneyLog.new(journey) }

  describe '.start' do
    it 'adds a journey into @Journeys' do
      allow(journey).to receive(:new) { journey }
      jl.start(station)
      expect(jl.journeys).to include(journey)
    end
  end

  describe '.finish' do
    it 'calls end_trip on our journey' do
      allow(journey).to receive_messages(new: journey, end_trip: journey)
      jl.start(station)
      expect(journey).to receive(:end_trip)
      jl.finish(station)
    end
  end
end
