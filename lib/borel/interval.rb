require 'borel/errors'

Infinity = 1/0.0

class Interval
  include Enumerable

  def Interval.[](*array)
    union(*
      if array.empty?
        []
      elsif array.first.kind_of?(Array)
        array.select{|x| !x.empty?}.map{|x| Simple.new(*x)}
      else
        [Simple.new(*array)]
      end
    )
  rescue
    unless
        array.size <= 2 || array.all?{|x| Array === x && x.size <= 2}
      raise Exception::Construction, array
    end
    raise
  end

  def Interval.union(*array)
    l = []
    array.map(&:components).flatten.sort_by(&:inf).each{|x|
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
      Multiple.new(l)
    end
  end

  def union(other)
    Interval.union(other.to_interval, self)
  end

  def intersect(other)
    other.to_interval.map{|y| map{|x| x.intersect(y)}}.
      flatten.reduce(:union) || Interval[]
  end

  def complement
    map{|x| x.to_interval.map(&:complement).reduce(:intersect)}.
      flatten.reduce(:union)
  end

  def minus(other)
    if other.empty?
      self
    else
      map{|x| other.to_interval.map{|y| x.minus(y)}.reduce(:intersect)}.
        flatten.reduce(:union) || Interval[]
    end
  end

  def ==(other)
    construction == other.construction
  end

  def include?(x)
    any?{|i| i.include? x}
  end

  def empty?
    components.empty?
  end

  def construction
    map &:construction
  end

  def degenerate?
    all? &:degenerate?
  end

  def hull
    if empty?
      Interval[]
    else
      Interval[components.first.inf, components.last.sup]
    end
  end

  def to_interval
    self
  end

  def inspect
    "Interval" + construction.inspect
  end

  def to_s
    inspect
  end

  alias_method :+, :union
  alias_method :|, :union
  alias_method :&, :intersect
  alias_method :^, :intersect
  alias_method :~, :complement
  alias_method :-, :minus
end

require 'borel/interval_multiple'
require 'borel/interval_simple'
