require 'spec_helper'
require 'borel/math_extensions'

describe "Intervals Math Extensions" do
  specify do
    Interval.should include Borel::Randomizable
  end

  specify do
    Interval.should include Borel::IntervalArithmetic
  end
end
