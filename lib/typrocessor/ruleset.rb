module Typrocessor
  class Ruleset < Array
    attr_accessor :name

    def self.create(name=nil, &block)
      collection = new(name)
      collection.instance_eval(&block)
      collection
    end

    def initialize(name)
      self.name = name
    end

    def replace(*args, &block)
      self << Typrocessor::Replace.new(*args, &block)
    end

    def ignore(*args)
      self << Typrocessor::Ignore.new(*args)
    end
  end
end
