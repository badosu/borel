require 'borel/interval'
require 'borel/nil_class.rb'

describe NilClass do
  context "#to_interval" do
    it "should be Interval[]" do
      nil.to_interval.should eq Interval[]
    end
  end
end
