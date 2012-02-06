class Range

  # Convert to Interval.
  #
  #  (1.2 .. 5.3).to_interval # => Interval[1.2, 5.3]
  #  (1 ... 4).to_interval    # => Interval[1, 3]
  #  (1 ... 3.1).to_interval  # Fails
  #
  def to_interval
    Interval[first,
      if exclude_end?
        (last - 1).succ - 1
      else
        last
      end]
  rescue NoMethodError
    if exclude_end? && !last.respond_to?(:succ)
      raise Interval::Exception::OpenRight, self
    end
    raise
  end

end
