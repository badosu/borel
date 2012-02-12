class Range
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
