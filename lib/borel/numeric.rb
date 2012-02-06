class Numeric
  #
  # Define a degenerate interval from a single value.
  #
  #  3.to_interval            # => Interval[3]
  #
  def to_interval
    Interval[self]
  end
end
