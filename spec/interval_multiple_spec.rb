require 'borel/interval'

describe Interval::Multiple do
  context "#inf" do
    specify "[[-1,2],[3]] -> -1" do
      Interval[[-1,2],[3]].inf.should be -1
    end
  end

  context "#sup" do
    specify "[[-1,2],[3]] -> 3" do
      Interval[[-1,2],[3]].sup.should be 3
    end
  end
end
