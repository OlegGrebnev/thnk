require_relative 'instance_counter'
require_relative 'made_by'

require_relative 'station'

require_relative 'route'

require_relative 'train'
require_relative 'passenger_train'
require_relative 'cargo_train'

require_relative 'car'
require_relative 'passenger_car'
require_relative 'cargo_car'

require_relative 'UI'

ui = UserInterface.new
ui.choose_option
