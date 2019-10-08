class Station
  attr_reader :station_name, :trains

  def initialize(station_name)
    @station_name = station_name
    @trains = []
  end
  def arrived(train)
    @trains << train
  end
  def departure(train)
    @trains.delete(train)
  end
end

class Route
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
end

class Train
  attr_reader :train_type, :train_number, :train_car, :train_route, :station
  attr_accessor :train_speed

  def initialize(train_number, train_type, train_car)
    @train_number = train_number
    @train_type = train_type
    @train_speed = 0
    @train_car = train_car
  end
  def train_stop
    @train_speed = 0
  end
  def add_train_car
    @train_car += 1 if @train_speed == 0
  end
  def delete_train_car
    @train_car -= 1 if @train_speed == 0 && @train_car > 0
  end
  def get_route(route)
    @train_route = route
#Перемещение на первую станцию в маршруте
    station = route.stations.first
    station.arrived(self)
    @current_station = station
  end
  def go_to_station(station)
    if [next_station, prev_station].include?(station)
      @current_station.departure(self)
      station.arrived(self)
      @current_station = station
    end
  end
  def go_to_next_station
    go_to_station(next_station)
  end
  def go_to_prev_station
    go_to_station(prev_station)
  end
  def next_station
    current_station_idx = @train_route.stations.index(@current_station)
    @train_route.stations[current_station_idx + 1] if current_station_idx < @train_route.stations.length - 1
  end
  def prev_station
    current_station_idx = @train_route.stations.index(@current_station)
    @train_route.stations[current_station_idx - 1] if current_station_idx > 0
  end
end

train1 = Train.new(123, "cargo", 56)
puts train1.train_speed = 1
puts train1.train_car
puts train1.train_stop
train1.add_train_car
train1.delete_train_car

station1 = Station.new("SPB")
station2 = Station.new("MSK")
station3 = Station.new("BLG")
station4 = Station.new("VLG")

route1 = Route.new(station1, station2)

route1.add_station(station3)

#route1.delete_station(station3)

#train1.get_route(route1)

route2 = Route.new(station4, station1)
route2.add_station(station2)
route2.add_station(station3)


#route1.add_station("BLG")

#route2.add_station("BLG")

#route1.show_route

train1.get_route(route2)
train1.go_to_station(station2)
train1.go_to_next_station
train1.go_to_prev_station
