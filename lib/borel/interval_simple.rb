class Interval::Simple < Interval

  attr :inf
  attr :sup

  def each
    yield(self)
    self
  end

  def components
    [self]
  end

  def initialize (a, b = a)
    if (a.respond_to?(:nan?) && a.nan?) || (b.respond_to?(:nan?) && b.nan?)
      @inf, @sup = -Infinity, Infinity
    else
      @inf, @sup = a, b
    end
    freeze
  end

  def intersect(other)
    Interval[[inf, other.inf].max, [sup, other.sup].min]
  end

  def complement
    Interval[-Infinity,inf] | Interval[sup,Infinity]
  end

  def minus (other)
    self & ~other
  end

  def construction
    extrema.uniq
  end

  def include?(x)
    inf <= x  && x <= sup
  end

  def extrema
    [inf, sup]
  end

  def degenerate?
    inf == sup
  end

  def simple?
    true
  end
end
