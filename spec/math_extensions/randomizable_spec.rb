require 'borel/math_extensions/randomizable'

describe Borel::Randomizable do
  it 'should include #random' do
    class Foo
      include Borel::Randomizable
    end

    Foo.instance_methods.should include :random
  end

  context '#random' do
    let(:interval){ Interval[1,10] }

    it 'should be a point inside the interval' do
      interval.should include interval.random
    end

    it 'should be a random number' do
      random_number = 3
      rand_mock = mock
      Random.should_receive(:new).and_return(rand_mock)
      rand_mock.should_receive(:rand).with(1..10).and_return(random_number)

      interval.random.should be random_number
    end

    it 'should run on multiple intervals' do
      pending
      interval = Interval[[1,5],[6,8]]
    end
  end

end
