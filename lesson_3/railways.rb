class Station
  attr_accessor :trains
  attr_reader :station_name

  def initialize(station_name)
    @station_name = station_name
    @trains = []
    puts "#{station_name}"
  end

  def arrived(train)
    @trains << train
    puts "Прибытие поезда #{train.train_number} на станцию #{station_name}"
  end

  def departure(train)
    @trains.delete(train)
  end

  def show_train
    @trains.each { |train| puts "На станции #{station_name} поезд(а) №: #{train.train_number}" }
  end
end

class Route
  attr_accessor :from_station, :to_station, :stations

  def initialize(from_station, to_station)
    @stations = [from_station, to_station]
    puts "Вы добавили маршрут #{stations.first.station_name} - #{stations.last.station_name}"
  end

  def add_station(station)
    if @stations.include?(station)
      puts "Станция в маршруте уже существует"
    else
      @stations.insert(-2, station)
      puts "К маршруту #{stations.first.station_name} - #{stations.last.station_name} добавилась станция #{station.station_name}"
    end
  end

  def delete_station(station)
    if [stations.first, stations.last].include?(station)
      puts "Вы не можете удалять станцию отправления и станцию назначения"
    elsif @stations.include?(station)
      @stations.delete(station)
      puts "Вы удалили станцию #{station.station_name} из маршрута #{stations.first.station_name} - #{stations.last.station_name}"
    else
      puts "Станции #{station.station_name} в маршруте не найдено!"
    end
  end

  def show_route
    @stations.each { |station| puts station.station_name }
  end
end

class Train
  attr_reader :train_type
  attr_accessor :train_number, :train_speed, :train_car, :train_route, :station

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
    if @train_speed == 0
      @train_car += 1
      puts "Вы прицепили вагон! Кол-во вагонов в составе поезда № #{train_number}: #{train_car}"
    else
      puts "Останови поезд! Текущая скорость #{train_speed}"
    end
  end

  def delete_train_car
    if @train_speed == 0 && @train_car > 0
      @train_car -= 1
      puts "Вы отцепили вагон! Кол-во вагонов в составе поезда № #{train_number}: #{train_car}"
    else
      puts "Останови поезд! Текущая скорость #{train_speed}"
    end
  end

  def get_route(route)
    @train_route = route
    puts "Поезд № #{train_number} следует по маршруту #{route.stations.first.station_name} - #{route.stations.last.station_name}"
#Перемещение на первую станцию в маршруте
    station = route.stations.first
    station.arrived(self)
    @c_station = station
  end

  def go_to_station(station)
    if [next_station, prev_station].include?(station)
      @c_station.departure(self)
      station.arrived(self)
      @c_station = station
    else
      puts "Станции нет в маршруте"
    end
  end

  def go_to_next_station
    go_to_station(next_station)
  end

  def go_to_prev_station
    go_to_station(prev_station)
  end

  def next_station
    c_station_idx = @train_route.stations.index(@c_station)
    @train_route.stations[c_station_idx + 1] if c_station_idx < @train_route.stations.length - 1
  end

  def prev_station
    c_station_idx = @train_route.stations.index(@c_station)
    @train_route.stations[c_station_idx - 1] if c_station_idx > 0
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

station1.show_train

route1 = Route.new(station1, station2)

route1.add_station(station3)

#route1.show_route

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


station3.show_train
station1.show_train
station2.show_train
