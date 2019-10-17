class CargoTrain < Train
  def initialize(number, type = "cargo")
    super
  end

  def add_car(car)
    super(car) if car.instance_of?(CargoCar)
  end
end