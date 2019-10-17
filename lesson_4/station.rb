class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name
    @trains = {}
  end

  def get_train(train)
    if trains[train.type]
      trains[train.type] << train
    else
      trains[train.type] = [train]
    end
  end

  def arrive(train)
    train.go_to_next_station
  end

  def departure(train)
    trains[train.type].delete(train)
  end

  def show_trains
    if trains.empty?
      puts "there are no trains at the station"
      return
    end
    puts "trains by type: "
    trains.each do |type, trains_by_type|
      puts "#{type}: "
      trains_by_type.each { |train| puts "#{train.number}" }
    end
  end
end
