require 'borel'

module Borel
  module IntervalArithmetic
    def width
      raise NonSimple, self unless self.respond_to?(:simple?) and self.simple?
      self.extrema.last - self.extrema.first
    end

    Interval.send(:include, self)
  end
end

