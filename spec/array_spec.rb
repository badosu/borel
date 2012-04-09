require 'borel/interval'
require 'borel/array.rb'

describe Array do
  context "#to_interval" do
    specify "[] -> Interval[]" do
      [].to_interval.should eq Interval[]
    end

    specify "[1,2] -> Interval[1,2]" do
      [1,2].to_interval.should eq Interval[1,2]
    end

    specify "[[1,2],[3,4]] -> Interval[[1,2],[3,4]]" do
      [[1,2],[3,4]].to_interval.should eq Interval[[1,2],[3,4]]
    end
  end
end
