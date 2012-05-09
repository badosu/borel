require 'borel'

module Borel
  # Includes numeric intervals related methods
  module IntervalArithmetic

    # @return [Number] the width of the interval
    # @example
    #   Interval[1,5].width # -> 5-1
    def width
      raise NonSimple, self unless respond_to?(:simple?) and simple?
      extrema.last - extrema.first
    end

    Interval.send(:include, self)
  end
end

