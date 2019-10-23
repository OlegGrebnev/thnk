module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstansMethods
    base.instance_variable_set :@instanses, 0
  end

  module ClassMethods
    def instanses
      @instanses
    end

    attr_accessor :instanses
  end

  module InstansMethods
    def register_instance
      self.class.register_instance += 1
    end
  end
end