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

    it '(1..Float::INFINITY) should be [1,infty]' do
      (1..Float::INFINITY).to_interval.should eq Interval[1,Float::INFINITY]
    end

    it '(1...Float::INFINITY) should raise OpenRight' do
      expect{(1...Float::INFINITY).to_interval}.to raise_error Borel::OpenRight
    end

    it '(-Float::INFINITY..1) should be [-infty,1]' do
      (-Float::INFINITY..1).to_interval.should eq Interval[-Float::INFINITY,1]
    end

    it '(-Float::INFINITY..Float::INFINITY) should be [-infty,infty]' do
      (-Float::INFINITY..Float::INFINITY).to_interval.
        should eq Interval[-Float::INFINITY,Float::INFINITY]
    end
  end
end
