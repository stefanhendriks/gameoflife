describe "GameOfLife" do
  describe "generation" do
    let(:generation) { Generation.new(cells) }

    describe "#next" do
      subject { generation.next }

      context "given an empty generation" do
        let(:cells) { [] }
        it { should eq([]) }
      end

      context "given a generation of one cell" do
        let(:cells) { [[0, 0]] }
        it { should eq ([]) }
      end

      context "given a generation of a cell with one adjecent cell" do
        let(:cells) { [[0, 0], [0, 1]] }
        it { should eq ([]) }
      end

      context "given a generation of a cell with with two adjectent cells" do
        let(:cells) { [[0, 0], [0, 1], [1, 0]] }
        it { should eq ([[0, 0]]) }
      end
    end

    describe "#neighbour_count(pos)" do
      subject { generation.neighbour_count(pos) }

      context "given an empty generation" do
        let(:pos) { [0,0] }
        let(:cells) { [] }
        it { should eq(0) }
      end

      context "given a generation with one" do
        let(:cells) { [ [1,1] ] }

        context "using a non adjecent position" do
          let(:pos) { [10,10] }
          it { should eq(0) }
        end

        context "using the same position as cell" do
          let(:pos) { [1,1] }
          it { should eq(0) }
        end

        context "using a position above cell" do
          let(:pos) { [1,0] }
          it { should eq(1) }
        end
      end

      describe "a position" do
        let(:pos) { [1, 1] }

        context "surrounded by cells" do
          let(:cells) do
            [
              [0, 0], [1, 0], [2, 0],
              [0, 1],         [2, 1],
              [0, 2], [1, 2], [2, 2]
            ]
          end
          it { should eq(8) }
        end

      end
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
      @cells = cells
    end

    def next
      []
    end

    def neighbour_count(pos)
      pos_x, pos_y = *pos
      neighbours = 0
      @cells.each do |x, y|
        neighbours += 1 if neighbours?(pos_x, pos_y, x, y)
      end
      neighbours
    end

    def neighbours?(pos_x, pos_y, x, y)
      distance(pos_x, x) == 1 || distance(pos_y, y) == 1
    end

    def distance(pos_x, x)
      (pos_x - x).abs
    end
  end
end
