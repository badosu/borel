require 'borel'

module Borel
  module Randomizable
    def random
      Random.new.rand(Range.new(*self.extrema))
    end

    Interval.send(:include, self)
  end
end

