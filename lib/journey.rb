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
    return check_penalty if check_penalty
    1
  end

  def complete?
    @journey[:complete]
  end

  private

  def check_penalty
    return if @journey[:entry_station] && @journey[:exit_station]
    end_trip() if @journey[:entry_station] && !@journey[:exit_station]
    return PENALTY_FARE
  end


end
