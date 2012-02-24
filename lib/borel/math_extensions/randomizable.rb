require 'borel'

module Borel
  module Randomizable
    def random
      Random.new.rand(Range.new(*self.extrema))
    end
  end
end

Interval.send(:include, Borel::Randomizable) if defined? Interval
