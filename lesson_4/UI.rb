class UserInterface
  def initialize
    @stations = []
    @trains = []
    @routes = []
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
        show_station_and_trains
      when 3
        create_train
      when 4
        create_route
      when 5
        manage_route
      when 6
        manage_train
      end
    end
  end

  private

  def menu
    [
        '[1] create station',
        '[2] show station and trains',
        '[3] create train',
        '[4] create route',
        '[5] manage route',
        '[6] manage trains',
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

  def create_station
    print "enter station name: "
    name = gets.chomp
    @stations << Station.new(name)
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
    print "enter train number: "
    number = gets.chomp
    @trains << choiced_train_type.new(number)
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
    puts "select item of start station: "
    start_station = choiced_station('start station')
    end_station = choiced_station('end station')
    @routes << Route.new(start_station, end_station)
    puts "you added route: #{@routes}"
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
        '[2] add car',
        '[3] remove car',
        '[4] move next station',
        '[5] move previous station'
    ]
  end

  def choiced_train
    choiced_entity('choiced train', @trains, :number)
  end

  def train_add_car(train)
    car_type = case train.type
               when 'passenger' then
                 PassengerCar
               when 'cargo' then
                 CargoCar
               end
    train.add_car(car_type.new)
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
      train.train_add_car
    when 3 then
      train.delete_car
    when 4 then
      train.go_to_next_station
    when 5 then
      train.go_to_prev_station
    end
  end

  def show_station_and_trains
    @stations.each do |station|
      print station.name + ' - '
      station.show_trains
    end
  end
end
