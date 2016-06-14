module Typrocessor
  module RulesetMaker
    def ruleset(name=nil, &block)
      Typrocessor::Ruleset.create(name, &block)
    end
  end
end
