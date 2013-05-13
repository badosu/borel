require 'spec_helper'
require 'borel/math_extensions/randomizable'

describe Borel::Randomizable do
  it 'should include #rand' do
    class Foo
      include Borel::Randomizable
    end

    Foo.instance_methods.should include :rand
  end

  context '#random' do
    let(:interval){ Interval[1,10] }
    let(:rand_mock) { mock }

    it 'should be a point inside the interval' do
      interval.should include interval.rand
    end

    it 'should be itself if degenerate' do
      Interval[5].rand.should be 5
    end

    it 'should be a random number on simple intervals' do
      random_number = 3
      Random.should_receive(:new).and_return(rand_mock)
      rand_mock.should_receive(:rand).with(1..10).and_return(random_number)

      interval.rand.should be random_number
    end

    it 'should run on multiple intervals by weight' do
      interval = Interval[[1,5],[6,8]]

      Random.should_receive(:new).exactly(2).times.and_return(rand_mock)
      rand_mock.should_receive(:rand).with(0..6).and_return(4)
      rand_mock.should_receive(:rand).with(1..5).and_return(3)

      interval.rand.should be 3

      Random.should_receive(:new).exactly(2).times.and_return(rand_mock)
      rand_mock.should_receive(:rand).with(0..6).and_return(6)
      rand_mock.should_receive(:rand).with(6..8).and_return(7)

      interval.rand.should be 7
    end

    it 'should raise error if empty' do
      expect{Interval[].rand}.
        to raise_error Borel::EmptyInterval
    end
  end

end
