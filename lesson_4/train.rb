class Train
  attr_reader :type, :number, :car, :route, :station
  attr_accessor :speed

  def initialize(number, type)
    @number = number
    @type = type
    @speed = 0
    @car = []
  end

  def train_stop?
    @speed.zero?
  end

  def add_car(car)
    @car << car if train_stop?
  end

  def delete_car
    @car.pop if train_stop? && !@car.empty?
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

  private

  #эти методы используются только для публичного интерфейса класса Train
  def go_to_station(station)
    if [next_station, prev_station].include?(station)
      @current_station.departure(self)
      station.arrive(self)
      @current_station = station
    end
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