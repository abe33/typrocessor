class Ignore
  attr_accessor :name, :expression

  def initialize(name, expression)
    self.expression = expression
    self.name = name
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

  def ranges(string)
    re = Regexp.new(source, options)

    ranges = []
    match = re.match(string)

    while !match.nil? do
      break if !ranges.empty? && (match.begin(0) == ranges.last.first || match.end(0) == ranges.last.last)
      ranges << [match.begin(0), match.end(0)]
      next_start = match.end(0)
      match = re.match(string, next_start)
    end

    return ranges
  end
end
