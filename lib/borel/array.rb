# Extends {#to_interval} for the {Array} class
class Array

  # Initializes an interval with the calling array as argument
  # @return [Interval]
  # @example
  #   [].to_interval              # -> Interval[]
  # @example
  #   [1,2].to_interval           # -> Interval[1,2]
  # @example
  #   [[1,2],[3,4]].to_interval   # -> Interval[[1,2],[3,4]]
  def to_interval
    Interval[*self]
  end
end
