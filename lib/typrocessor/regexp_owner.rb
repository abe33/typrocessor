module Typrocessor
  module RegExpOwner
    def get_regexp
      Regexp.new(source, options)
    end

    def source
      expression.is_a?(Regexp) ?
        expression.source.force_encoding('utf-8') :
        expression
    end

    def options
      expression.is_a?(Regexp) ?
        flags.reduce(0) {|m,f| (expression.options & f) > 0 ? m + f : m } :
        0
    end

    def flags
      [Regexp::IGNORECASE, Regexp::MULTILINE]
    end
  end
end
