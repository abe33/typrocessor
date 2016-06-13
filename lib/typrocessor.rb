class Typrocessor
  attr_accessor :rules

  def initialize(options={})
    self.rules = []
    self.rules = options.delete(:rules) if options.has_key?(:rules)
  end

  def clean(string)
    return if string.nil?
    return string if self.rules.empty?

    rules = self.rules.select {|r| r.is_a?(Rule) }
    ignores = self.rules.select {|r| r.is_a?(Ignore) }

    return string if rules.empty?

    ranges = compactRanges(ignores.map {|i| i.ranges(string) }.flatten(1))

    included, excluded = splitByRanges(string, ranges)

    alternateJoin(
      included.map {|s,i| rules.reduce(s) {|s, rule| rule.fix(s) } },
      excluded
    )
  end

  def rangesIntersects (rangeA, rangeB)
    startA, endA = rangeA
    startB, endB = rangeB

    return (startB >= startA && startB <= endA) ||
           (endB >= startA && endB <= endA) ||
           (startA >= startB && startA <= endB) ||
           (endA >= startB && endA <= endB)
  end

  def splitByRanges (string, ranges)
    included = []
    excluded = []

    start = 0
    ranges.each do |range|
      included << string[start...range[0]]
      excluded << string[range[0]...range[1]]
      start = range[1]
    end
    included << string[start...string.length]

    return [included, excluded]
  end

  def alternateJoin (a, b)
    string = ''

    a.each_with_index do |s, i|
      string += s
      string += b[i] if b[i]
    end

    return string
  end

  def compactRanges (ranges)
    return [] if ranges.empty?

    newRanges = ranges.reduce [] do |memo, rangeA|
      if memo.empty?
        memo << rangeA
        memo
      else
        newMemo = memo.select do |rangeB|
          if rangesIntersects(rangeA, rangeB)
            rangeA[0] = [rangeA[0], rangeB[0]].min
            rangeA[1] = [rangeA[1], rangeB[1]].max
            false
          else
            true
          end
        end

        newMemo + [rangeA]
      end
    end

    newRanges.sort {|a, b| a[0] - b[0] }
  end
end
