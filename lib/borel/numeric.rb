# Extends {#to_interval} for the {Numeric} class
class Numeric
  # Initializes an interval with the calling number as the only point
  # @return [Interval]
  def to_interval
    Interval[self]
  end
end
