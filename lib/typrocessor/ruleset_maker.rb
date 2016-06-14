module Typrocessor::RulesetMaker
  def ruleset(&block)
    collection = Ruleset.new
    collection.instance_eval(&block)
    collection
  end

  class Ruleset < Array
    def replace(*args)
      self << Typrocessor::Replace.new(*args)
    end

    def ignore(*args)
      self << Typrocessor::Ignore.new(*args)
    end
  end
end
