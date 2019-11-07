class Station
  attr_reader :name, :trains

  include InstanceCounter

  @@stations = []

  def self.all
    @@stations
  end

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

  private

  def validate!
    raise 'This is station already exist. Create new station' if @@stations.any? { |station| station != self && station.name == name }
  end
end
