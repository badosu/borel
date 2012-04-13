require 'borel/errors'

# Exposes infinity for initializing unbounded intervals
Infinity = 1/0.0

# Retains all non-specific Interval logic
class Interval
  include Enumerable

  # @return [Interval]
  def self.[](*array)
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
    unless array.size <= 2 || array.all?{|x| Array === x && x.size <= 2}
      raise Exception::Construction, array
    end
    raise
  end

  # @return [Interval]
  def self.union(*array)
    intervals = []
    array.map(&:components).flatten.sort_by(&:inf).each do |component|
      if component.sup < component.inf
        next
      elsif intervals.empty? || component.inf > intervals.last.sup
        intervals <<= component
      elsif component.sup > intervals.last.sup
        intervals[-1] = Simple.new(intervals.last.inf, component.sup)
      end
    end
    intervals.size == 1 ? intervals.first : Multiple.new(intervals)
  end

  # @return [Interval]
  def union(other)
    Interval.union(other.to_interval, self)
  end

  # @return [Interval]
  def intersect(other)
    other.to_interval.map{|y| map{|x| x.intersect(y)}}.
      flatten.reduce(:union) || Interval[]
  end

  # @return [Interval]
  def complement
    map{|x| x.to_interval.map(&:complement).reduce(:intersect)}.
      flatten.reduce(:union)
  end

  # @return [Interval]
  def intersect(other)
    other.to_interval.map{|y| map{|x| x.intersect(y)}}.
      flatten.reduce(:union) || Interval[]
  end

  # @return [Interval]
  def minus(other)
    if other.empty?
      self
    else
      map{|x| other.to_interval.map{|y| x.minus(y)}.reduce(:intersect)}.
        flatten.reduce(:union) || Interval[]
    end
  end

  # @return [Boolean]
  def ==(other)
    construction == other.construction
  end

  # @return [Boolean]
  def empty?
    components.empty?
  end

  # @return [Interval]
  def to_interval
    self
  end

  # @return [String]
  def inspect
    "Interval" + construction.inspect
  end

  # @return [String]
  def to_s
    inspect
  end

  # @return [Interval]
  def hull
    if empty? then Interval[] else Interval[inf, sup] end
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
