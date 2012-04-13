# Retains the logic specific for intervals with multiple components
class Interval::Multiple < Interval
  attr :components

  # @return [Interval]
  def initialize(array)
    @components = array
    freeze
  end

  # @return [Interval]
  def each
    components.each{|o| yield(o)}
    self
  end

  # @return [Object]
  def inf
    components.first.inf
  end

  # @return [Object]
  def sup
    components.last.sup
  end

  # @return [Array]
  def construction
    map &:construction
  end

  # @return [Boolean]
  def include?(x)
    any?{|i| i.include? x}
  end

  # @return [Boolean]
  def degenerate?
    all? &:degenerate?
  end

  # @return [Boolean]
  def simple?
    false
  end
end
