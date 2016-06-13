class Rule
  attr_accessor :name, :expression, :replacement

  def initialize(name, expression, replacement)
    self.name = name
    self.expression = expression
    self.replacement = replacement
  end

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

  def fix (string)
    regex = Regexp.new(source, options)

    if replacement.is_a?(Proc)
      string.gsub(regex, &replacement)
    else
      string.gsub(regex, replacement)
    end
  end
end
