require 'borel'

module Borel
  module IntervalArithmetic
    def width
      raise NonSimple, self unless respond_to?(:simple?) and simple?
      extrema.last - extrema.first
    end

    Interval.send(:include, self)
  end
end

