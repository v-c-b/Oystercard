# Journey holds information about journey and calculates fares
class Journey
  attr_reader :journey

  PENALTY_FARE = 4
  BASE_FARE = 1

  def initialize(entry = nil, exit = nil, complete = false)
    @journey = { entry_station: entry, exit_station: exit, complete: complete, zones: 0 }
  end

  def end_trip(station = nil)
    @journey[:exit_station] = station
    @journey[:complete] = true
  end

  def fare
    return check_penalty if check_penalty
    zones_travelled + BASE_FARE
  end

  def complete?
    @journey[:complete]
  end

  private

  def zones_travelled
    zones = (@journey[:entry_station].zone - @journey[:exit_station].zone).abs
    @journey[:zones] = zones
    zones
  end

  def check_penalty
    return if @journey[:entry_station] && @journey[:exit_station]
    end_trip if @journey[:entry_station] && !@journey[:exit_station]
    PENALTY_FARE
  end
end
