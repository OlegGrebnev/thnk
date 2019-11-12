# frozen_string_literal: true

class CargoTrain < Train
  include InstanceCounter
  def initialize(number, type = :cargo)
    super
    register_instance
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end
