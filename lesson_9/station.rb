# frozen_string_literal: true

class Station
  include InstanceCounter
  include Validation

  @@stations = []

  def self.all
    @@stations
  end

  attr_reader :name, :trains
  validate :name, :presence

  def initialize(name)
    @name = name
    validate!
    @trains = []
    @@stations << self
    register_instance
  end

  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  def get_train(train)
    trains << train
  end

  def arrive(train)
    train.go_to_next_station
  end

  def departure(train)
    trains.delete(train)
  end

  def each_train
    trains.each { |train| yield(train) } unless trains.empty?
  end
end
