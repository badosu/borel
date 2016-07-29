require 'spec_helper'
require 'borel/interval'

describe Interval::Simple do
  context "#intersect" do
    specify "[1,2]; [[1], [2]] -> [[1], [2]]" do
      x = Interval[[1, 2]]
      y = Interval[[1], [2]]
      x.intersect(y).should eq y
    end
  end
end
