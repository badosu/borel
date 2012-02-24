require 'borel/math_extensions/interval_arithmetic'

module Borel
  module Randomizable
    def random
      if self.simple?
        Random.new.rand Range.new *self.extrema
      elsif self.degenerate?
        self.extrema.first
      else
        total_weight = self.map(&:width).reduce(:+)
        selected_weight = Random.new.rand 0..total_weight
        rand_interval = self.find{|c| (selected_weight -= c.width) <= 0}
        Random.new.rand Range.new *rand_interval.extrema
      end
    end

    Interval.send(:include, self)
  end
end
