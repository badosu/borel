# Retains the logic specific for intervals with a single component
# in the form [inf,sup]
class Interval::Simple < Interval
  attr :inf
  attr :sup

  def initialize (a, b = a)
    if (a.respond_to?(:nan?) && a.nan?) || (b.respond_to?(:nan?) && b.nan?)
      @inf, @sup = -Float::INFINITY, Float::INFINITY
    else
      @inf, @sup = a, b
    end
    freeze
  end

  # @return [Simple]
  def each
    yield(self)
    self
  end

  # @return [Interval]
  def intersect(other)
    Interval[[inf, other.inf].max, [sup, other.sup].min]
  end

  # @return [Interval::Multiple]
  def complement
    Interval[[-Float::INFINITY, inf], [sup, Float::INFINITY]]
  end

  # @return [Interval]
  def minus(other)
    other.complement.intersect self
  end

  # @return [Array<Interval>]
  def components
    [self]
  end

  # @return [Array]
  def extrema
    [inf, sup]
  end

  # @return [Array]
  def construction
    extrema.uniq
  end

  # Verifies that a point is inside the interval
  #
  # @param [Comparable] x the point to be verified
  # @return [Boolean]
  # @example
  #   Interval[1,5].include?(3.4)   # -> true
  def include?(x)
    inf <= x && x <= sup
  end

  # Verifies that the Interval is degenerate, i.e. the extrema are equal
  # @example
  #   Interval[1,2].degenerate?     # -> false
  #   Interval[1].degenerate?       # -> true
  # @return [Boolean]
  def degenerate?
    inf == sup
  end

  # Verifies that this class represents simple intervals
  # @return [Boolean]
  def simple?
    true
  end
end
