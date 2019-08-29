class Journey
  attr_reader :journey

  PENALTY_FARE  = 4

  def initialize(entry = nil, exit = nil, complete = false)
    @journey = {entry_station: entry, exit_station: exit, complete: complete}
  end

  def end_trip(station)
    @journey[:exit_station] = station
    @journey[:complete] = true
  end

  def fare
    return PENALTY_FARE if @journey[:entry_station] && !@journey[:exit_station]
    return PENALTY_FARE if !@journey[:entry_station] && @journey[:exit_station]
    1
  end

  def complete?
    @journey[:complete]
  end
end
