# frozen_string_literal: true

class CargoCar < Car
  def initialize(capacity)
    super(capacity)
    @type = :cargo
  end
end
