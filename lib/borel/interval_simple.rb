# Retains the logic specific for intervals with a single component
# in the form [inf,sup]
class Interval::Simple < Interval
  attr :inf
  attr :sup

  def initialize (a, b = a)
    if (a.respond_to?(:nan?) && a.nan?) || (b.respond_to?(:nan?) && b.nan?)
      @inf, @sup = -Infinity, Infinity
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
    Interval[[-Infinity, inf], [sup, Infinity]]
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

  # @return [Boolean]
  def include?(x)
    inf <= x && x <= sup
  end

  # @return [Boolean]
  def degenerate?
    inf == sup
  end

  # @return [Boolean]
  def simple?
    true
  end
end
