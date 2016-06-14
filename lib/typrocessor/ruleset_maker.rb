module Typrocessor
  module RulesetMaker
    def ruleset(&block)
      collection = Typrocessor::Ruleset.new
      collection.instance_eval(&block)
      collection
    end
  end
end
