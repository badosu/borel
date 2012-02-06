require File.expand_path(File.join(File.dirname(__FILE__), './numeric'))
require File.expand_path(File.join(File.dirname(__FILE__), './range'))

class Interval
  include Enumerable

  def Interval.[](*array)
    union(*
      if array.empty?
        []
      elsif array.first.kind_of?(Array)
        array.select{|x| !x.empty?}.map { |x| Simple.new(*x) }
      else
        [Simple.new(*array)]
      end
    )
  rescue StandardError
    unless
        array.all?{|x| Numeric === x} && array.size <= 2 ||
        array.all?{|x| Array === x && x.size <= 2 && x.all?{|c| Numeric === c}}
      raise Exception::Construction, array
    end
    raise
  end

  def Interval.union(*array)
    l = []
    array.map{|x| x.components}.flatten.sort_by{|x| x.inf}.each{|x|
      if x.sup < x.inf
        # skip it
      elsif l.empty? || x.inf > l.last.sup
        l <<= x
      elsif x.sup > l.last.sup
        l[-1] = Simple.new(l.last.inf, x.sup)
      end
    }
    if l.size == 1
      l.first
    else
      Interval::Multiple.new(l)
    end
  end

  def construction
    map{|x| x.extrema.uniq}
  end

  def simple?
    false
  end

  def inspect
    "Interval" + construction.inspect
  end

  def to_s
    inspect
  end

  def == (other)
    self.class === other && self.components == other.components
  end

  def include?(x)
    any?{|i| i.include?(x)}
  end

  def to_interval
    self
  end

  def coerce (other)
    [other.to_interval, self]
  end

  def & (other)
    # implemented below
  end

  [[:&, :intersect]].each {|op, meth|
    define_method(op) {|other|
      Interval.union(*other.to_interval.map {|y| self.map {|x| x.send(meth,y) } }.flatten)
    }
  }

  def ~ (other)
    # implemented below
  end

  [[:~, :minus]].each {|op, meth|
    define_method(op) {|other|
      self.map{|x| other.to_interval.map{|y| x.send(meth,y) }.reduce(:&) }.flatten.reduce(:|)
    }
  }

  def | (other)
    Interval.union(other.to_interval, self)
  end

  def empty?
    components.empty?
  end

  def sharp?
    all? {|x| x.sharp?}
  end

  def degenerate?
    all? {|x| x.degenerate?}
  end

  def hull
    if empty?
      Interval[]
    else
      Interval[components.first.inf, components.last.sup]
    end
  end

end

class Interval::Simple < Interval
  attr :inf
  attr :sup

  include Enumerable

  def each
    yield(self)
    self
  end

  def components
    [self]
  end

  def initialize (a, b = a)
    raise ArgumentError, "Extrema must be numeric: #{[a,b].uniq.inspect}" unless
      Numeric === a && Numeric === b
    if (a.respond_to?(:nan?) && a.nan? ) || (b.respond_to?(:nan?) && b.nan?)
      @inf, @sup = -Infinity, Infinity
    else
      @inf, @sup = a, b
    end
    freeze
  end

  def construction
    extrema.uniq
  end

  def simple?
    true
  end

  def == (other)
    self.class == other.class && inf == other.inf && sup == other.sup
  end

  def include?(x)
    inf <= x  && x <= sup
  end

  def extrema
    [inf,sup]
  end

  def width
    sup - inf
  end

  def midpoint
    (inf + sup) * 2 **-1
  end

  def number
    if inf == sup
      inf
    else
      raise Exception::Nondegenerate, self
    end
  end

  def intersect (other)
    self.class.new([inf,other.inf].max, [sup,other.sup].min)
  end

  def minus (other)
    if other.sup < inf || other.inf > sup                 # ( ) [ ] ( )
      self
    elsif other.inf == sup                                # [ X )
      Interval[sup]
    elsif other.sup == inf                                # ( X ]
      Interval[inf]
    elsif other.sup < sup && other.inf > inf              # [( )]
      Interval[other.sup, sup] | Interval[inf, other.inf]
    elsif other.sup > sup && other.inf < inf              # ([ ])
      Interval[]
    elsif sup > other.sup                                 # ([ )] | X )]
      Interval[other.sup,sup] | (inf == other.inf ? Interval[inf] : Interval[] )
    elsif inf <= other.inf                                 # [( ]) | [( X | X ])
      Interval[inf,other.inf] | (sup == other.sup ? Interval[sup] : Interval[] )
    elsif other.sup == sup
      Interval[sup]
    end
  end

  def sharp?
    w = width
    if w == 0
      true
    elsif w.kind_of?(Float) && (inf >= 0  || sup <= 0)
      s1, s2 = extrema.map{|x| x.abs}.sort
      s1 + s1.to_f.ulp == s2
    else
      false
    end
  end

  def degenerate?
    inf == sup
  end

end

class Interval::Multiple < Interval

  attr :components

  def initialize(array)
    @components = array
    freeze
  end

  def each
    components.each { |o| yield(o) }
    self
  end

  [:number,:midpoint,:width].each{|f|
    define_method(f) {
      raise Exception::Nonsimple, self
    }
  }

end

class Interval
  module Exception
    class Construction < ArgumentError
      def initialize(array)
        super(
          "An interval can only be constructed either from at most two " \
          "numbers or from a sequence of arrays of at most two numbers: " +
          array.inspect)
      end
    end

    class Nondegenerate < ArgumentError
      def initialize(i)
        super("#{i.inspect} is not degenerate.")
      end
    end

    class Nonsimple < ArgumentError
      def initialize(i)
        super("#{i.inspect} is not simple.")
      end
    end

    class OpenRight < ArgumentError
      def initialize(range)
        super(
          "Cannot construct an interval from a three-dot range " \
          "with end-value of type #{range.last.class}.")
      end
    end
  end
end
