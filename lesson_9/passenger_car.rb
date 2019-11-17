# frozen_string_literal: true

class PassengerCar < Car
  def initialize(capacity)
    super(capacity)
    @type = :passenger
  end

  def occupancy
    super(1)
  end
end
