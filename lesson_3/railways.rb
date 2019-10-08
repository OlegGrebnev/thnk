class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = []
  end

  def arrive(train)
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
  attr_reader :type, :number, :car, :route, :station
  attr_accessor :speed

  def initialize(number, type, car)
    @number = number
    @type = type
    @speed = 0
    @car = car
  end

  def train_stop
    @speed = 0
  end

  def add_train_car
    @car += 1 if @speed == 0
  end

  def delete_train_car
    @car -= 1 if @speed == 0 && @car > 0
  end

  def get_route(route)
    @route = route
#Перемещение на первую станцию в маршруте
    station = route.stations.first
    station.arrive(self)
    @current_station = station
  end

  def go_to_station(station)
    if [next_station, prev_station].include?(station)
      @current_station.departure(self)
      station.arrive(self)
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
    current_station_idx = @route.stations.index(@current_station)
    @route.stations[current_station_idx + 1] if current_station_idx < @route.stations.length - 1
  end

  def prev_station
    current_station_idx = @route.stations.index(@current_station)
    @route.stations[current_station_idx - 1] if current_station_idx > 0
  end
end

train1 = Train.new(123, "cargo", 56)
puts train1.speed = 1
puts train1.add_train_car
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
