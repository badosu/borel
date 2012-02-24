require 'borel/math_extensions/random'

describe Borel::MathExtensions::Random do
  it 'should include #random on Interval' do
    Interval.instance_methods.should include :random
  end
end
