class Route
  attr_reader :stations

  include InstanceCounter

  def initialize(from_station, to_station)
    @stations = [from_station, to_station]
    validate!
    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
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

  private

  def validate!
    raise 'There are no stations for create route. Create stations before' unless @stations.all? { |element| element.is_a?(Station) }
  end
end
