module Typrocessor
  class Processor
    attr_accessor :rules

    def initialize(options={})
      self.rules = []
      self.rules = options.delete(:rules) if options.has_key?(:rules)
    end

    def clean(string)
      return if string.nil?
      return string if self.rules.empty?

      replaces = self.rules.select {|r| r.is_a?(Typrocessor::Replace) }
      ignores = self.rules.select {|r| r.is_a?(Typrocessor::Ignore) }

      return string if replaces.empty?

      ranges = compact_ranges(ignores.map {|i| i.ranges(string) }.flatten(1))

      included, excluded = split_by_ranges(string, ranges)

      alternate_join(
        included.map {|s| replaces.reduce(s) {|s, replace| replace.exec(s) } },
        excluded
      )
    end

    def ranges_intersects (range_a, range_b)
      start_a, end_a = range_a
      start_b, end_b = range_b

      (start_b >= start_a && start_b <= end_a) ||
      (end_b >= start_a && end_b <= end_a) ||
      (start_a >= start_b && start_a <= end_b) ||
      (end_a >= start_b && end_a <= end_b)
    end

    def split_by_ranges (string, ranges)
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

    def alternate_join (a, b)
      string = ''

      a.each_with_index do |s, i|
        string += s
        string += b[i] if b[i]
      end

      return string
    end

    def compact_ranges (ranges)
      return [] if ranges.empty?

      new_ranges = ranges.reduce [] do |memo, range_a|
        if memo.empty?
          memo << range_a
          memo
        else
          new_memo = memo.select do |range_b|
            if ranges_intersects(range_a, range_b)
              range_a[0] = [range_a[0], range_b[0]].min
              range_a[1] = [range_a[1], range_b[1]].max
              false
            else
              true
            end
          end

          new_memo + [range_a]
        end
      end

      new_ranges.sort {|a, b| a[0] - b[0] }
    end
  end
end
