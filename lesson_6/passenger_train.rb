class PassengerTrain < Train
  include InstanceCounter
  def initialize(number, type = :passenger)
    super
    register_instance
  end

  def add_car(car)
    super(car) if @type == car.type
  end
end
