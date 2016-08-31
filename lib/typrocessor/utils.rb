module Typrocessor::Utils
  def self.space_by_group(m, group_size=2, separator=' ')
    m.reverse.split(/(\d{#{group_size}})/).select {|s| !s.empty? }.join(separator).reverse
  end
end
