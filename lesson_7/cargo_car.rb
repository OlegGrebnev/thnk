class CargoCar < Car
  def initialize(capacity)
    super(capacity)
    @type = :cargo
  end
end
