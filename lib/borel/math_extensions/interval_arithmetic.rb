require 'borel'

module Borel
  # Includes numeric intervals related methods
  module IntervalArithmetic
    # @return [Number] the width of the interval
    def width
      raise NonSimple, self unless respond_to?(:simple?) and simple?
      extrema.last - extrema.first
    end

    Interval.send(:include, self)
  end
end

