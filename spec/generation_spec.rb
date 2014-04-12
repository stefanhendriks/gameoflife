require 'generation'
require 'generation_factory'

describe "generation" do
  let(:generation) { GenerationFactory.build(cells) }

  describe "#next" do
    subject { generation.next }

    context "given an empty generation" do
      let(:cells) { "" }
      it { should eq([]) }
    end

    context "given a generation of one cell" do
      let(:cells) { "x" }
      it { should eq ([]) }
    end

    context "given a generation of a cell with one adjecent cell" do
      let(:cells) { "xx" }
      it { should eq ([]) }
    end

    context "cell with two neighbours survives" do
      let(:cells) do
        "    \n" +
        "   x\n" +
        "  x \n" +
        " x  \n"
      end
      it do
        should eq ([
          [2, 2],
        ])
      end
    end

    context "dead cell revives with 3 cells" do
      let(:cells) do
        "    \n" +
        "   x\n" +
        " x  \n" +
        "   x\n"
      end
      it { should eq ([
        [2, 2],
      ]) }
    end
  end

  describe "#neighbour_count(pos, cells)" do
    subject { Generation.neighbour_count(pos, cells) }

    context "given an empty generation" do
      let(:pos) { [0, 0] }
      let(:cells) { [] }
      it { should eq(0) }
    end

    context "given a generation with one" do
      let(:cells) { [[1, 1]] }

      context "using a non adjecent position" do
        let(:pos) { [10, 10] }
        it { should eq(0) }
      end

      context "using the same position as cell" do
        let(:pos) { [1, 1] }
        it { should eq(0) }
      end

      context "using a position above cell" do
        let(:pos) { [1, 0] }
        it { should eq(1) }
      end
    end

    describe "a position" do
      let(:pos) { [1, 1] }

      context "surrounded by cells" do
        let(:cells) do
          [
            [0, 0], [1, 0], [2, 0],
            [0, 1], [2, 1],
            [0, 2], [1, 2], [2, 2]
          ]
        end
        it { should eq(8) }
      end

    end
  end
end

#context "alive cell that survives lives on in next generation" do
#  before do
#
#  end
#end
#
#context "alive cell that dies is not in next generation" do
#
#end
#
#context "dead cell that revives is in next generation" do
#
#end
#
#context "dead cell that does not revive is not in the next generation" do
#
#end

