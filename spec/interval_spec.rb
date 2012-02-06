require 'borel/interval'

describe Interval do
  context '#minus' do
    it 'should be itself when ( ) [ ]' do
      (Interval[2,3].~ Interval[0,1]).should eq Interval[2,3]
    end

    it 'should be itself when [ ] ( )' do
      (Interval[0,1].~ Interval[2,3]).should eq Interval[0,1]
    end

    it 'should be empty when ([ ])' do
      (Interval[1,2].~ Interval[0,3]).should be_empty
    end

    it 'should be [[,],[,]] when [( )]' do
      (Interval[0,3].~ Interval[1,2]).should eq Interval[0,1] | Interval[2,3]
    end

    it 'should be [[X],[X]] when X X' do
      (Interval[0,1].~ Interval[0,1]).should eq Interval[0] | Interval[1]
    end

    it 'should be [[X]] when ( X ]' do
      (Interval[1,2].~ Interval[2,3]).should eq Interval[2]
    end

    it 'should be [[X]] when [ X )' do
      (Interval[2,3].~ Interval[1,2]).should eq Interval[2]
    end

    it 'should be [,] when ([ )]' do
      (Interval[1,4].~ Interval[0,3]).should eq Interval[3,4]
    end

    it 'should be [,] when [( ])' do
      (Interval[1,3].~ Interval[2,4]).should eq Interval[1,2]
    end

    it 'should be [[X],[,]] when X )]' do
      (Interval[1,4].~ Interval[1,3]).should eq Interval[3,4] | Interval[1]
    end

    it 'should be [[X]] when X ])' do
      (Interval[1,4].~ Interval[1,5]).should eq Interval[1]
    end

    it 'should be [[,],[X]] when [( X' do
      (Interval[1,3].~ Interval[2,3]).should eq Interval[1,2] | Interval[3]
    end

    it 'should be [[X]] when ([ X' do
      (Interval[1,3].~ Interval[0,3]).should eq Interval[3]
    end
  end
end
