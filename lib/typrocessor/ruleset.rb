module Typrocessor
  class Ruleset < Array
    def replace(*args)
      self << Typrocessor::Replace.new(*args)
    end

    def ignore(*args)
      self << Typrocessor::Ignore.new(*args)
    end
  end
end
