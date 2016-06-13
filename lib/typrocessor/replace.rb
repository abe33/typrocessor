module Typrocessor
  class Replace
    include Typrocessor::RegExpOwner

    attr_accessor :name, :expression, :replacement

    def initialize(name, expression, replacement=nil, &block)
      self.name = name
      self.expression = expression
      self.replacement = block_given? ? block : replacement

      if self.replacement.nil?
        raise 'Missing replacement argument or block in Replace.new'
      end
    end

    def exec(string)
      re = get_regexp

      replacement.is_a?(Proc) ?
        string.gsub(re, &replacement) :
        string.gsub(re, replacement)
    end
  end
end
