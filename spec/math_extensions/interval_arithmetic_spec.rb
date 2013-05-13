require 'spec_helper'
require 'borel/math_extensions/interval_arithmetic'

describe Borel::IntervalArithmetic do
  it "should include #width" do
    class Foo
      include Borel::IntervalArithmetic
    end

    Foo.instance_methods.should include :width
  end

  context "#width" do
    specify "Interval[1,2] -> 1" do
      Interval[1,2].width.should be 1
    end

    specify "Interval[-1,2] -> 3" do
      Interval[-1,2].width.should be 3
    end

    specify "Interval[1] -> 0" do
      Interval[1].width.should be 0
    end

    it "should raise error if not simple" do
      expect{Interval[].width}.
        to raise_error Borel::NonSimple

      expect{Interval[[1,2],[3,4]].width}.
        to raise_error Borel::NonSimple
    end
  end
end
