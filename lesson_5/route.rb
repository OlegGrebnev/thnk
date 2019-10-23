class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(from_station, to_station)
    @stations = [from_station, to_station]
  end

  def add_station(station)
    @stations.insert(-2, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  def to_s
    stations
        .map(&:name)
        .join("=>")
  end

  def show_route
    print to_s
  end
end
