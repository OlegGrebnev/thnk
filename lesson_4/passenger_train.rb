class PassengerTrain < Train
  def initialize(number, type = "passenger")
    super
  end

  def add_car(car)
    super(car) if car.instance_of?(PassengerCar)
  end
end