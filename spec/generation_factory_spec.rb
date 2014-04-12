require 'generation_factory'

describe "GenerationFactory" do
  describe ".build" do
    subject { GenerationFactory.build(grid) }

    context "empty string returns empty grid" do
      let(:grid) { "" }
      its(:alive_cells) { should eq([]) }
    end

    context "with only one x returns position 0,0" do
      let(:grid) { "x" }
      its(:alive_cells) { should eq([[0, 0]]) }
    end

    context "with only multiple x's on same line" do
      let(:grid) { "x x x" }
      its(:alive_cells) { should eq([[0, 0], [2, 0], [4, 0]]) }
    end

    context "with x's on different lines" do
      let(:grid) do
        "x\n" +
          "x"
      end
      its(:alive_cells) { should eq([[0, 0], [0, 1]]) }
    end

    context "example grid" do
      let(:grid) do
        "x x x\n" +
          " x x \n" +
          "  x  \n"
      end
      its(:alive_cells) do
        should eq([
                    [0, 0], [2, 0], [4, 0],
                    [1, 1], [3, 1],
                    [2, 2]
                  ])
      end
    end
  end
end
