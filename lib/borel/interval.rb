require 'borel/errors'

# Exposes `Infinity` and `-Infinity` for initializing unbounded intervals
Infinity = 1/0.0

# Retains all non-specific Interval logic
class Interval
  include Enumerable

  # Initializes an Interval
  #
  # @param [Array<Comparable>,Array<Array<Comparable>>] array none, one or
  #  multiple 1,2-length arrays
  # @example Empty interval
  #   Interval[]
  # @example An interval with only one point
  #   Interval[1]
  # @example A simple interval
  #   Interval[0,1]
  # @example A non simple interval
  #   Interval[[0,1],[2,3],[5]]
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

  # Performs the union of Intervals
  # @param Array<Interval> array the intervals to be united
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

  # Performs the operation of union with other interval
  # @example
  #   Interval[1,2].union(3..4) == Interval[[1,2],[3,4]] # true
  # @param [#to_interval] other the other interval-compatible object
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

  # Implemented for establishing obvious interval-compatibility
  # @return [Interval] returns `self`
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

  # The convex hull of the Interval
  # Note that for simple Intervals it is itself
  #
  # @example
  #   Interval[].hull == Interval[] # true
  # @example
  #   Interval[[1,2],[3,4]].hull == Interval[1,4] # true
  #
  # @return [Interval] a simple Interval composed by the inf and sup points
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
