class Journey
  attr_reader :journey

  PENALTY_FARE  = 4

  def initialize(entry = nil, exit = nil, complete = false)
    @journey = {entry_station: entry, exit_station: exit, complete: complete}
  end

  def end_trip(station = nil)
    @journey[:exit_station] = station
    @journey[:complete] = true
  end

  def fare
    if @journey[:entry_station] && !@journey[:exit_station]
      end_trip()
      return PENALTY_FARE
    end
    return PENALTY_FARE if !@journey[:entry_station] && @journey[:exit_station]
    1
  end

  def complete?
    @journey[:complete]
  end
end
