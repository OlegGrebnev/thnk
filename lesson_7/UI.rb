class UserInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def menu
    [
        '[1] create station',
        '[2] show station and trains',
        '[3] create train',
        '[4] create route',
        '[5] manage route',
        '[6] manage trains',
        '[7] show trains and cars',
        '[0] exit'
    ]
  end

  def show_option(title, menu)
    puts title
    menu.each { |option| puts option }
  end

  def select_option
    print "select option: "
    gets.chomp.to_i
  end

  def choose_option
    loop do
      show_option('menu', menu)
      choice = select_option
      break if choice.zero?

      case choice
      when 1
        create_station
      when 2
        show_stations
      when 3
        create_train
      when 4
        create_route
      when 5
        manage_route
      when 6
        manage_train
      when 7
        show_trains_and_cars
      end
    end
  end

  def seed
    moscow = Station.new('MSK')
    sant_petersburg = Station.new('SPB')
    bologoe = Station.new('BLG')
    @stations = [moscow, sant_petersburg, bologoe]

    msk_spb = Route.new(moscow, sant_petersburg)
    spb_blg = Route.new(sant_petersburg, bologoe)
    @routes = [msk_spb, spb_blg]

    ptrain = PassengerTrain.new('125-PA')
    ctrain = CargoTrain.new('900-CA')
    @trains = [ptrain, ctrain]

    pcar = PassengerCar.new(36)
    pcar.occupancy

    ccar = CargoCar.new(480)
    ccar.occupancy(380)

    ptrain.add_car(pcar)
    ptrain.add_car(PassengerCar.new(72))
    ctrain.add_car(ccar)

    ptrain.get_route(msk_spb)
    ctrain.get_route(spb_blg)
  end

  def create_station
    begin
      print "enter station name: "
      name = gets.chomp
      @stations << Station.new(name)
    rescue RuntimeError => e
      input_error(e.message)
      retry
    end
  end

  def train_type_menu
    [
        '[1] passanger',
        '[2] cargo'
    ]
  end

  def create_train
    show_option('create train', train_type_menu)
    choice = select_option
    choiced_train_type = case choice
                         when 1 then
                           PassengerTrain
                         when 2 then
                           CargoTrain
                         end
    begin
      print "enter train number: "
      number = gets.chomp
      @trains << choiced_train_type.new(number)
    rescue RuntimeError => e
      input_error(e.message)
      retry
    end
  end

  def choiced_entity(title, entity_collection, attr_name)
    menu_option = entity_collection.map.with_index do
    |entity, idx|
      "[#{idx + 1}] #{entity.public_send attr_name}"
    end
    show_option(title, menu_option)
    entity_collection[select_option - 1]
  end

  def choiced_station(title = 'station')
    choiced_entity("choice #{title}", @stations, :name)
  end

  def create_route
    begin
      start_station = choiced_station('start station')
      end_station = choiced_station('end station')
      @routes << Route.new(start_station, end_station)
      puts "you added route: #{@routes}"
    rescue RuntimeError => e
      input_error(e.message)
    end
  end

  def choiced_route
    choiced_entity('choice_route', @routes, :to_s)
  end

  def route_menu
    [
        '[1] add station to route',
        '[2] delete station from route'
    ]
  end

  def manage_route
    route = choiced_route
    show_option('choice item for modify route: ', route_menu)
    case select_option
    when 1 then
      route.add_station(choiced_station)
    when 2 then
      route.delete_station(choiced_station)
    end
  end

  def train_menu
    [
        '[1] set route',
        '[2] manage cars',
        '[3] move next station',
        '[4] move previous station'
    ]
  end

  def choiced_train
    choiced_entity('choiced train', @trains, :number)
  end

  def train_add_car(train)
    car_type = case train.type
               when :passenger then
                 PassengerCar
               when :cargo then
                 CargoCar
               end
    puts 'enter car capacity'
    capacity = gets.chomp.to_i
    train.add_car(car_type.new(capacity))
  end

  def manage_train
    if @trains.empty?
      puts "there are no trains created! choose [3] of menu items"
      return
    end
    train = choiced_train
    show_option('manage train', train_menu)
    case select_option
    when 1 then
      train.get_route(choiced_route)
    when 2 then
      manage_cars(train)
    when 3 then
      train.go_to_next_station
    when 4 then
      train.go_to_prev_station
    end
  end

  def choiced_car(cars)
    choiced_entity('choice car', cars, :number)
  end

  def car_menu
    [
        '[1] add car',
        '[2] remove car',
        '[3] occupy',
        '[4] show cars'
    ]
  end

  def manage_cars(train)
    show_option('manage cars', car_menu)
    case select_option
    when 1 then
      train_add_car(train)
    when 2 then
      train.delete_car
    when 3 then
      occupancy(train)
    when 4 then
      show_cars(train)
    end
  end

  def occupancy(train)
    car = choiced_car(train.cars)

    case train.type
    when :passenger
    then
      car.occupancy
    when :cargo
    then
      puts 'enter cargo occupancy amount'
      amount = gets.chomp.to_i
      car.occupancy(amount)
    end
  end

  def show_cars(train)
    if train.cars.empty?
      puts "there are no train cars"
    else
      #puts "#:#{train.number}[#{train.type}]:"
      train.each_car do |car|
        puts "#:#{car.number}, capacity:#{car.capacity}, available capacity:#{car.available_capacity}"
      end
    end
  end

  def show_trains(station)
    if station.trains.empty?
      puts 'There are no trains on the station'
    end
    station.each_train do |train|
      puts "number: #{train.number}, type: #{train.type}, cars: #{train.cars.length}"
      puts show_cars(train)
    end
  end

  def show_stations
    @stations.each do |station|
      print station.name + ' - '
      show_trains(station)
    end
  end

  def show_trains_and_cars
    @trains.each do |train|
      puts "the [#{train.type}] train # #{train.number} count of cars: #{train.show_cars}"
    end
  end

  def input_error(msg)
    puts "input error: #{msg}"
  end
end
