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

  def simple?
    false
  end
end
