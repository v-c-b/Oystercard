# Journeylog holds journeys and delegates to journey
class JourneyLog
  attr_reader :journeys

  def initialize(journey_class = Journey)
    @journeys = []
    @journey_c = journey_class
  end

  def start(station)
    @journeys << @journey_c.new(station)
  end

  def finish(station)
    @journeys[-1].end_trip(station)
  end

  def fare
    @journeys[-1].fare
  end

  def empty?
    @journeys.empty?
  end

  def create_missing_journey(station)
    @journeys << @journey_c.new(nil, station, true) if empty? || !in_journey?
  end

  def log
    @journeys.each { |x| puts x.journey }
  end

  def in_journey?
    !@journeys[-1].complete? unless empty?
  end
end
