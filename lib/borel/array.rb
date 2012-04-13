# Extends {#to_interval} for the {Array} class
class Array

  # Initializes an interval with the calling array as argument
  # @return [Interval]
  def to_interval
    Interval[*self]
  end
end
