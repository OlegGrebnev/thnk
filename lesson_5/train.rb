class Train
  attr_reader :type, :number, :cars, :route, :station
  attr_accessor :speed

  include MadeBy
  include InstanceCounter

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @cars = []
    @@trains[number] = self
    register_instance
  end

  def train_stop?
    @speed.zero?
  end

  def add_car(car)
    @cars << car if train_stop?
  end

  def delete_car
    @cars.pop if train_stop? && !@cars.empty?
  end

  def show_cars
    if @cars.empty?
      puts "there are no train cars"
    else
      @cars.length
    end
  end

  def get_route(route)
    @route = route
    #Перемещение на первую станцию в маршруте
    station = route.stations.first
    station.get_train(self)
    @current_station = station
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

  private

  #эти методы используются только для публичного интерфейса класса Train
  def go_to_station(station)
    if [next_station, prev_station].include?(station)
      @current_station.departure(self)
      station.get_train(self)
      @current_station = station
    end
  end
end
