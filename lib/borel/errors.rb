module Borel
  # Raised when an interval is not properly initialized
  class Construction < ArgumentError
    def initialize(array)
      super(
        "An interval can only be constructed either from at most two " \
        "numbers or from a sequence of arrays of at most two numbers: " +
        array.inspect)
    end
  end

  # Raised when a non-degenerate interval calls a method supported only for
  # degenerate intervals
  class NonDegenerate < ArgumentError
    def initialize(i)
      super("#{i.inspect} is not degenerate.")
    end
  end

  # Raised when a non simple interval calls a method supported only for simple
  # intervals
  class NonSimple < ArgumentError
    def initialize(i)
      super("#{i.inspect} is not simple.")
    end
  end

  # Raised when a method is not supported for empty intervals
  class EmptyInterval < ArgumentError
    def initialize
      super("The interval is empty.")
    end
  end

  # Raised when the {Range#to_interval} is not called properly
  class OpenRight < ArgumentError
    def initialize(range)
      super(
        "Cannot construct an interval from a three-dot range " \
        "with end-value #{range.last.inspect}.")
    end
  end
end
