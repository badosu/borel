# Extends {#to_interval} for the {Array} class
class NilClass

  # Initializes an empty interval
  # @return [Interval]
  # @example
  #   nil.to_interval     # -> Interval[]
  def to_interval
    Interval[]
  end
end
