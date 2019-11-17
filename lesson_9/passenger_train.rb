# frozen_string_literal: true

class PassengerTrain < Train
  include InstanceCounter

  validate :number, :presence
  validate :number, :type, String
  validate :number, :format, NUMBER_FORMAT

  def initialize(number, type = :passenger)
    super
    register_instance
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end
