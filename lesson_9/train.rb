# frozen_string_literal: true

class Train
  include MadeBy
  include Accessors
  include Validation

  NUMBER_FORMAT = /^[\da-z]{3}-?[\da-z]{2}$/i.freeze

  @@trains = {}

  attr_reader :type, :number, :cars, :route, :station
  strong_attr_accessor :speed, Numeric

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, type)
    @number = number
    @type = type
    validate!
    @speed = 0
    @cars = []
    @@trains[number] = self
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
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
    1
  end

  def each_car
    cars.each { |car| yield(car) } unless cars.empty?
  end

  def get_route(route)
    @route = route
    # Follow to first route station
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
    @route.stations[current_station_idx - 1] if current_station_idx.positive?
  end

  private

  def go_to_station(station)
    return if station.nil?

    @current_station.departure(self)
    station.get_train(self)
    @current_station = station
  end
end
