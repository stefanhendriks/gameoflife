describe "GameOfLife" do
  describe "next generation" do
    let(:cell) { Cell.new(alive) }

    describe "dead cell" do
      let(:alive) { false }
      subject { cell.next_generation(neighbours) }

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
      subject { cell.next_generation(neighbours) }

      context "with less then two neighbours" do
        let(:neighbours) { 1 }
        it { should be_true }
      end

      context "with more than three neighbours" do
        let(:neighbours) { 4 }
        it { should be_true }
      end

      context "survives with exactly two neighbours" do
        let(:neighbours) { 2 }
        it { should be_false }
      end

      context "survives with exactly three neighbours" do
        let(:neighbours) { 3 }
        it { should be_false }
      end
    end
  end

  class Cell
    def initialize(alive)
      @alive = alive
    end

    def next_generation(neighbours)
      if @alive
        dies(neighbours)
      else
        revives(neighbours)
      end
    end

    def revives(neighbours)
      neighbours == 3
    end

    def dies(neighbours)
      (neighbours < 2) || (neighbours > 3)
    end
  end
end
