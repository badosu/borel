require 'borel/math_extensions'

describe "Intervals Math Extensions" do
  specify do
    Interval.should include Borel::Randomizable
  end
end
