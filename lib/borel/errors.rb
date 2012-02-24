module Borel
  class Construction < ArgumentError
    def initialize(array)
      super(
        "An interval can only be constructed either from at most two " \
        "numbers or from a sequence of arrays of at most two numbers: " +
        array.inspect)
    end
  end

  class NonDegenerate < ArgumentError
    def initialize(i)
      super("#{i.inspect} is not degenerate.")
    end
  end

  class NonSimple < ArgumentError
    def initialize(i)
      super("#{i.inspect} is not simple.")
    end
  end

  class EmptyInterval < ArgumentError
    def initialize
      super("The interval is empty.")
    end
  end

  class OpenRight < ArgumentError
    def initialize(range)
      super(
        "Cannot construct an interval from a three-dot range " \
        "with end-value #{range.last.inspect}.")
    end
  end
end
