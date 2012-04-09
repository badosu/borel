class Interval::Multiple < Interval
  attr :components

  def initialize(array)
    @components = array
    freeze
  end

  def each
    components.each{|o| yield(o)}
    self
  end

  def inf
    components.first.inf
  end

  def sup
    components.last.sup
  end

  def construction
    map &:construction
  end

  def include?(x)
    any?{|i| i.include? x}
  end

  def degenerate?
    all? &:degenerate?
  end

  def simple?
    false
  end
end
