class Station
  attr_accessor :station_name, :trains
   def initialize(station_name)
     @station_name = station_name
     @trains = []
   end

  def arrived(train)
    @trains << train
  end

  def show_train
    @trains.each { |train| puts train.number }
  end
end

class Route
  attr_accessor :stations
  def initialize(from, to)
    @stations = [from, to]
  end
end

class Train

  attr_accessor :number, :route, :first_station

  def initialize(number)
    @number = number
  end

   def get_route(route)
     @route = route
     @first_station = route.stations.first
     @first_station.arrived(self)
   end

end

st1 = Station.new("MSK")
st2 = Station.new("SPB")

r1 = Route.new(st1, st2)

r2 = Route.new(st2, st1)

t1 = Train.new(1245)
t2 = Train.new(9965)

t1.get_route(r1)
t2.get_route(r2)

p st1.show_train