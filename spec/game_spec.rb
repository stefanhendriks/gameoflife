describe "GameOfLife" do
  describe "generation" do
    let(:generation) { Generation.new(cells) }
    subject { generation.next }

    context "given an empty generation" do
      let(:cells) { [] }
      it { should eq([]) }
    end
  end

  describe "Cell evolve" do
    subject { Cell.evolve(alive, neighbours) }

    describe "dead cell" do
      let(:alive) { false }

      context "revives with exactly 3 neighbours" do
        let(:neighbours) { 3 }
        it { should be_true }
      end

      context "remains dead with more than 3 neighbours" do
        let(:neighbours) { 4 }
        it { should be_false }
      end

      context "remains dead with less than 2 neighbours" do
        let(:neighbours) { 2 }
        it { should be_false }
      end
    end

    describe "alive cell" do
      let(:alive) { true }

      context "dies with less then two neighbours" do
        let(:neighbours) { 1 }
        it { should be_false }
      end

      context "dies with more than three neighbours" do
        let(:neighbours) { 4 }
        it { should be_false }
      end

      context "survives with exactly two neighbours" do
        let(:neighbours) { 2 }
        it { should be_true }
      end

      context "survives with exactly three neighbours" do
        let(:neighbours) { 3 }
        it { should be_true }
      end
    end

  end

  class Cell
    def self.evolve(alive, neighbour_count)
      if alive
        !dies(neighbour_count)
      else
        revives(neighbour_count)
      end
    end

    def self.revives(neighbours)
      neighbours == 3
    end

    def self.dies(neighbours)
      (neighbours < 2) || (neighbours > 3)
    end
  end

  class Generation
    def initialize(cells)

    end

    def next
      []
    end
  end
end
