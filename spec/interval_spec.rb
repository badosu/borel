require 'borel/interval'

describe Interval do
  context '#intersection' do

    it "[]^[] = []" do
      (Interval[] ^ Interval[]).should eq Interval[]
    end

    it "[]^[0,3] = []" do
      (Interval[] ^ Interval[0,3]).should eq Interval[]
    end

    it "[0,3]^[] = []" do
      (Interval[0,3] ^ Interval[]).should eq Interval[]
    end

    it "[0,2]^[1] = [1]" do
      (Interval[0,2] ^ Interval[1]).should eq Interval[1]
    end

    it "[-infty, infty]^[0,1] = [0,1]" do
      (Interval[-Infinity, Infinity] ^ Interval[0,1]).should eq Interval[0,1]
    end

    it "[0,3]^[1,2] = [1,2]" do
      (Interval[0,3] ^ Interval[1,2]).should eq Interval[1,2]
    end

    it "[[-2,-1],[1,2]]^[[0,3],[4,5]] = [1,2]" do
      (Interval[[-2,-1],[1,2]] ^ Interval[[0,3],[4,5]]).should eq Interval[1,2]
    end
  end

  context '#union' do
    it "[]U[] = []" do
      (Interval[] | Interval[]).should eq Interval[]
    end

    it "[]U[1,2] = [1,2]" do
      (Interval[] | Interval[1,2]).should eq Interval[1,2]
    end

    it "[1,2]U[] = [1,2]" do
      (Interval[1,2] | Interval[]).should eq Interval[1,2]
    end

    it "[0,3]U[1,2] = [0,3]" do
      (Interval[0,3] | Interval[1,2]).should eq Interval[0,3]
    end

    it "[1,2]U[0,3] = [0,3]" do
      (Interval[1,2] | Interval[0,3]).should eq Interval[0,3]
    end

    it "[1,2]U[1,2] = [1,2]" do
      (Interval[1,2] | Interval[1,2]).should eq Interval[1,2]
    end

    it "[1,2]U[2,3] = [1,3]" do
      (Interval[1,2] | Interval[2,3]).should eq Interval[1,3]
    end

    it "[1,2]U[3,4] = [[1,2],[3,4]]" do
      (Interval[1,2] | Interval[3,4]).should eq Interval[[1,2],[3,4]]
    end
  end

  context '#minus' do
    it "[]-[] = []" do
      (Interval[] - Interval[]).should eq Interval[]
    end

    it "[1,2]-[] = [1,2]" do
      (Interval[1,2] - Interval[]).should eq Interval[1,2]
    end

    it "[]-[1,2] = []" do
      (Interval[] - Interval[1,2]).should eq Interval[]
    end

    it "[2,3]-(0,1) = [2,3]" do
      (Interval[2,3] - Interval[0,1]).should eq Interval[2,3]
    end

    it '[0,1]-(2,3) = [0,1]' do
      (Interval[0,1] - Interval[2,3]).should eq Interval[0,1]
    end

    it '[1,2]-(0,3) = []' do
      (Interval[1,2] - Interval[0,3]).should be_empty
    end

    it '[0,3]-(1,2) = [0,1]U[2,3]' do
      (Interval[0,3] - Interval[1,2]).should eq Interval[[0,1],[2,3]]
    end

    it '[0,1]-(0,1) = [0]U[1]' do
      (Interval[0,1] - Interval[0,1]).should eq Interval[[0],[1]]
    end

    it '[1,2]-(2,3) = [1,2]' do
      (Interval[1,2] - Interval[2,3]).should eq Interval[1,2]
    end

    it '[2,3]-(1,2) = [2,3]' do
      (Interval[2,3] - Interval[1,2]).should eq Interval[2,3]
    end

    it '[1,4]-(0,3) = [3,4]' do
      (Interval[1,4] - Interval[0,3]).should eq Interval[3,4]
    end

    it '[1,3]-(2,4) = [1,2]' do
      (Interval[1,3] - Interval[2,4]).should eq Interval[1,2]
    end

    it '[1,4]-(1,3) = [1]U[3,4]' do
      (Interval[1,4] - Interval[1,3]).should eq Interval[[1],[3,4]]
    end

    it '[1,4]-(1,5) = [1]' do
      (Interval[1,4] - Interval[1,5]).should eq Interval[1]
    end

    it '[1,3]-(2,3) = [1,2]U[3]' do
      (Interval[1,3] - Interval[2,3]).should eq Interval[[1,2],[3]]
    end

    it '[1,3]-(0,3) = [3]' do
      (Interval[1,3] - Interval[0,3]).should eq Interval[3]
    end

    it '[-infty,infty]-[0,1] = [-infty,0]U[1,infty]' do
      (Interval[-Infinity,Infinity] - Interval[0,1]).should eq Interval[[-Infinity,0],[1,Infinity]]
    end

    it '[0,1]-[-infty,infty] = []' do
      (Interval[0,1] - Interval[-Infinity,Infinity]).should eq Interval[]
    end
  end
end
