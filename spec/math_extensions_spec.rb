require 'borel/math_extensions'

describe Borel::MathExtensions do
  specify do
    Interval.should include Borel::MathExtensions::Random
  end
end
