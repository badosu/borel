require 'borel/interval'

describe Interval do
  context '#intersection' do

    specify "[]^[] = []" do
      (Interval[] ^ Interval[]).should eq Interval[]
    end

    specify "[]^[0,3] = []" do
      (Interval[] ^ Interval[0,3]).should eq Interval[]
    end

    specify "[0,3]^[] = []" do
      (Interval[0,3] ^ Interval[]).should eq Interval[]
    end

    specify "[0,2]^[1] = [1]" do
      (Interval[0,2] ^ Interval[1]).should eq Interval[1]
    end

    specify "[-infty, infty]^[0,1] = [0,1]" do
      (Interval[-Infinity, Infinity] ^ Interval[0,1]).should eq Interval[0,1]
    end

    specify "[0,3]^[1,2] = [1,2]" do
      (Interval[0,3] ^ Interval[1,2]).should eq Interval[1,2]
    end

    specify "[[-2,-1],[1,2]]^[[0,3],[4,5]] = [1,2]" do
      (Interval[[-2,-1],[1,2]] ^ Interval[[0,3],[4,5]]).should eq Interval[1,2]
    end
  end

  context '#union' do
    specify "[]U[] = []" do
      (Interval[] | Interval[]).should eq Interval[]
    end

    specify "[]U[1,2] = [1,2]" do
      (Interval[] | Interval[1,2]).should eq Interval[1,2]
    end

    specify "[1,2]U[] = [1,2]" do
      (Interval[1,2] | Interval[]).should eq Interval[1,2]
    end

    specify "[0,3]U[1,2] = [0,3]" do
      (Interval[0,3] | Interval[1,2]).should eq Interval[0,3]
    end

    specify "[1,2]U[0,3] = [0,3]" do
      (Interval[1,2] | Interval[0,3]).should eq Interval[0,3]
    end

    specify "[1,2]U[1,2] = [1,2]" do
      (Interval[1,2] | Interval[1,2]).should eq Interval[1,2]
    end

    specify "[1,2]U[2,3] = [1,3]" do
      (Interval[1,2] | Interval[2,3]).should eq Interval[1,3]
    end

    specify "[1,2]U[3,4] = [[1,2],[3,4]]" do
      (Interval[1,2] | Interval[3,4]).should eq Interval[[1,2],[3,4]]
    end
  end

  context '#minus' do
    specify "[]-[] = []" do
      (Interval[] - Interval[]).should eq Interval[]
    end

    specify "[1,2]-[] = [1,2]" do
      (Interval[1,2] - Interval[]).should eq Interval[1,2]
    end

    specify "[]-[1,2] = []" do
      (Interval[] - Interval[1,2]).should eq Interval[]
    end

    specify "[2,3]-(0,1) = [2,3]" do
      (Interval[2,3] - Interval[0,1]).should eq Interval[2,3]
    end

    specify '[0,1]-(2,3) = [0,1]' do
      (Interval[0,1] - Interval[2,3]).should eq Interval[0,1]
    end

    specify '[1,2]-(0,3) = []' do
      (Interval[1,2] - Interval[0,3]).should be_empty
    end

    specify '[0,3]-(1,2) = [0,1]U[2,3]' do
      (Interval[0,3] - Interval[1,2]).should eq Interval[[0,1],[2,3]]
    end

    specify '[0,1]-(0,1) = [0]U[1]' do
      (Interval[0,1] - Interval[0,1]).should eq Interval[[0],[1]]
    end

    specify '[1,2]-(2,3) = [1,2]' do
      (Interval[1,2] - Interval[2,3]).should eq Interval[1,2]
    end

    specify '[2,3]-(1,2) = [2,3]' do
      (Interval[2,3] - Interval[1,2]).should eq Interval[2,3]
    end

    specify '[1,4]-(0,3) = [3,4]' do
      (Interval[1,4] - Interval[0,3]).should eq Interval[3,4]
    end

    specify '[1,3]-(2,4) = [1,2]' do
      (Interval[1,3] - Interval[2,4]).should eq Interval[1,2]
    end

    specify '[1,4]-(1,3) = [1]U[3,4]' do
      (Interval[1,4] - Interval[1,3]).should eq Interval[[1],[3,4]]
    end

    specify '[1,4]-(1,5) = [1]' do
      (Interval[1,4] - Interval[1,5]).should eq Interval[1]
    end

    specify '[1,3]-(2,3) = [1,2]U[3]' do
      (Interval[1,3] - Interval[2,3]).should eq Interval[[1,2],[3]]
    end

    specify '[1,3]-(0,3) = [3]' do
      (Interval[1,3] - Interval[0,3]).should eq Interval[3]
    end

    specify '[-infty,infty]-[0,1] = [-infty,0]U[1,infty]' do
      (Interval[-Infinity,Infinity] - Interval[0,1]).
        should eq Interval[[-Infinity,0],[1,Infinity]]
    end

    specify '[0,1]-[-infty,infty] = []' do
      (Interval[0,1] - Interval[-Infinity,Infinity]).should eq Interval[]
    end
  end
end

describe "Generic Interval" do
  describe "when I use String Intervals" do
    it "should initialize ['a']" do
      Interval["a"].construction.should eq ["a"]
    end

    it "should initialize ['a','b']" do
      Interval["a","b"].construction.should eq ["a","b"]
    end

    it "should initialize [['a','c'],['b','d'],['e']] as [['a','d'],['e']]" do
      Interval[["a","c"],["b","d"],["e"]].
        construction.should eq [["a","d"],["e"]]
    end

    specify "['c','e']|['d','f']|['g']|[] = [['c','f'],['g']]" do
      (Interval['c','e'] | Interval['d','f'] | Interval['g'] | Interval[]).
        construction.should eq [['c','f'],['g']]
    end

    specify "['a','c']^[] = []" do
      (Interval['a','c'] ^ Interval[]).
        construction.should eq []
    end

    specify "['a','b']^['c','d'] = []" do
      (Interval['a','b'] ^ Interval['c','d']).
        construction.should eq []
    end

    specify "['a','c']^['b','d'] = ['b','c']" do
      (Interval['a','c'] ^ Interval['b','d']).
        construction.should eq ['b','c']
    end

    specify "['a','c']^['b','d']^['f'] = []" do
      (Interval['a','c'] ^ Interval['b','d'] ^ Interval['f']).
        construction.should eq []
    end

    describe "when upper bound is 'a' and lower bound is 'z'" do
      specify "~['d','f'] = ['a','d']|['f','z']" do
        pending
        (~Interval['d','f']).construction.should eq [['a','d'],['f','z']]
      end

      specify "['d','f']-['a','e'] = ['e','f']" do
        pending
        (Interval['d','f']-Interval['a','e']).
          construction.should eq ['e','f']
      end
    end
  end
end
