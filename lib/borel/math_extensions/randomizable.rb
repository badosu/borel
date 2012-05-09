require 'borel/math_extensions/interval_arithmetic'

module Borel
  # Includes methods for picking random elements on intervals
  module Randomizable

    # @example
    #   Interval[1,5].rand  # -> Random.new.rand 1..5
    # @return [Object] a random element of the interval
    def rand
      raise EmptyInterval if respond_to?(:empty?) and empty?

      if simple?
        Random.new.rand Range.new *extrema
      else
        total_weight = map(&:width).reduce(:+)
        selected_weight = Random.new.rand 0..total_weight
        rand_interval = find{|c| (selected_weight -= c.width) <= 0}
        Random.new.rand Range.new *rand_interval.extrema
      end
    end

    Interval.send(:include, self)
  end
end
