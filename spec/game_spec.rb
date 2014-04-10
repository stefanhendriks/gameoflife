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
        it { should eq ([[0, 0], [0, 1], [1, 0]]) }
      end

      context "given a generation of a cell with with four adjectent cells" do
        let(:cells) do
          [[1, 1], [2, 1], [3, 1],
           [1, 2], [2, 2]]
        end

        it { should eq ([
          [1, 1], [3, 1], [1, 2]
        ]) }
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
    def initialize(alive_cells)
      @cells = alive_cells
    end

    def next
      next_gen = []
      @cells.map do |cell|
        count = neighbour_count(cell)
        #p "#{cell} has #{count} neighbours"
        next_gen << cell if Cell.evolve(true, count)
      end
      next_gen
    end

    def neighbour_count(pos)
      pos_x, pos_y = *pos
      neighbours = 0
      @cells.each do |x, y|
        if neighbours?(pos_x, pos_y, x, y)
          #p "#{pos} is neighbours with #{x},#{y}"
          neighbours += 1
        end
      end
      neighbours
    end

    def neighbours?(pos_x, pos_y, x, y)
      dist_x = distance(pos_x, x).abs
      dist_y = distance(pos_y, y).abs
      return true if (dist_x == 1 && dist_y == 0)
      return true if (dist_x == 0 && dist_y == 1)
      return true if (dist_x == 1 && dist_y == 1)
      false
    end

    def distance(pos_x, x)
      (pos_x - x)
    end
  end
end
