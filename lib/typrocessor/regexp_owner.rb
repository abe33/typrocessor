module Typrocessor
  module RegExpOwner
    def source
      expression.is_a?(Regexp) ? expression.source.force_encoding('utf-8') : expression
    end

    def options
      flags = 0
      if expression.is_a?(Regexp)
        flags += Regexp::IGNORECASE if (expression.options & Regexp::IGNORECASE) > 0
        flags += Regexp::MULTILINE if (expression.options & Regexp::MULTILINE) > 0
      else
        flags = 0
      end

      flags
    end

  end
end
