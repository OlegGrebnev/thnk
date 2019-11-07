class Car
  include MadeBy
  attr_reader :type, :capacity, :occupied, :number

  def initialize(capacity)
    @capacity = capacity
    @occupied = 0
    @number = rand(1..999).to_s
  end

  def occupancy(amount)
    self.occupied += amount if available_capacity >= amount
  end

  def available_capacity
    capacity - occupied
  end

  protected

  attr_writer :occupied
end
