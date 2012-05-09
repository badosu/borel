# Extends {#to_interval} for the {Array} class
class Range

  # @return [Interval]
  # @example
  #   (1..2).to_interval  # -> Interval[1,2]
  # @example
  #   (1...3).to_interval # -> Interval[1,2]
  def to_interval
    Interval[first,
      if exclude_end?
        (last - 1).succ - 1
      else
        last
      end]
  rescue NoMethodError
    raise Borel::OpenRight, self if exclude_end? && !last.respond_to?(:succ)
    raise
  end
end
