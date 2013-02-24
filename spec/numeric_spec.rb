require 'borel/interval'
require 'borel/numeric'

describe Numeric do
  context "#to_interval" do

    it "-1 should be [-1]" do
      -1.to_interval.should eq Interval[-1]
    end

    it "0 should be [0]" do
      0.to_interval.should eq Interval[0]
    end

    it "1 should be [1]" do
      1.to_interval.should eq Interval[1]
    end

    it "-3.23 should be [-3.23]" do
      -3.23.to_interval.should eq Interval[-3.23]
    end

    it "1/0 should be [Infinity]" do
      (1/0.0).to_interval.should eq Interval[Float::INFINITY]
    end

    it "Infinity should be [Infinity]" do
      (-1/0.0).to_interval.should eq Interval[-Float::INFINITY]
    end

  end
end

