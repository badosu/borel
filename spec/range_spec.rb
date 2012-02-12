require 'borel/interval'
require 'borel/range'

describe Range do
  context '#to_interval' do
    it '(1..3) should be [1,3]' do
      (1..3).to_interval.should eq Interval[1,3]
    end

    it '(1...3) should be [1,2]' do
      (1...3).to_interval.should eq Interval[1,2]
    end

    it '(1..Infinity) should be [1,infty]' do
      (1..Infinity).to_interval.should eq Interval[1,Infinity]
    end

    it '(1...Infinity) should raise OpenRight' do
      expect{(1...Infinity).to_interval}.to raise_error Borel::OpenRight
    end

    it '(-Infinity..1) should be [-infty,1]' do
      (-Infinity..1).to_interval.should eq Interval[-Infinity,1]
    end

    it '(-Infinity..Infinity) should be [-infty,infty]' do
      (-Infinity..Infinity).to_interval.should eq Interval[-Infinity,Infinity]
    end
  end
end
