module Typrocessor
  class Replace
    include Typrocessor::RegExpOwner

    attr_accessor :name, :expression, :replacement

    def initialize(name, expression, replacement)
      self.name = name
      self.expression = expression
      self.replacement = replacement
    end

    def exec(string)
      regex = Regexp.new(source, options)

      replacement.is_a?(Proc) ?
        string.gsub(regex, &replacement) :
        string.gsub(regex, replacement)
    end
  end
end
