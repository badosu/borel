# Extends {#to_interval} for the {Array} class
class NilClass

  # Initializes an empty interval
  # @return [Interval]
  def to_interval
    Interval[]
  end
end
