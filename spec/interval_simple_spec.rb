require 'spec_helper'
require 'borel/interval'

describe Interval::Simple do
  context "#intersect" do
    specify "[1,2]; [[1], [2]] -> [[1], [2]]" do
      x = Interval[[1, 2]]
      y = Interval[[1], [2]]
      expect(x.intersect y).to eq y
    end
  end

end
